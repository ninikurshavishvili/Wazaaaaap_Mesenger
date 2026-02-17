//
//  AuthManager.swift
//  Wazaaaaap_App
//
//  Created by Nino Kurshavishvili on 22.12.24.
//

import FirebaseAuth
import Firebase
import UIKit
import GoogleSignIn
import FirebaseCore

struct ChatRoomUser {
    let uid: String
    let name: String
    let email: String?
    let photoURL: String?
}

enum GoogleSignInError: Error {
    case errorWithGoogleSignIn
    case signInPresentationError
    case authSignInError
    case unableToGrabTopVC
}

class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    func getCurrentUser() -> ChatRoomUser? {
        guard let authUser = auth.currentUser else {
            return nil
        }
        return ChatRoomUser(uid: authUser.uid, name: authUser.displayName ?? "unknown", email: authUser.email, photoURL: authUser.photoURL?.absoluteString)
    }
    
    func signInWithGoogle(completion: @escaping (Result<ChatRoomUser, GoogleSignInError>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found")
        }
                

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        guard let topVC = UIApplication.getTopViewController() else {
            completion(.failure(.unableToGrabTopVC))
           return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { [unowned self] result, error in
          
          guard let user = result?.user,
            let idToken = user.idToken?.tokenString,
                    error == nil
          else {
              completion(.failure(.signInPresentationError))
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            auth.signIn(with: credential) { result, error in
                guard let result = result, error == nil else {
                    completion(.failure(.authSignInError))
                    return
                }
                let user = ChatRoomUser(uid: result.user.uid, name: result.user.displayName ?? "UnKnown", email: result.user.email, photoURL: result.user.photoURL?.absoluteString)
                completion(.success(user))
            }
        }
    }
    
    func signOut()  throws {
        try auth.signOut()
    }
    
    func signUpWithEmailAndPassword(email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            let chatroomUser = User(id: result.user.uid, fullname: fullname, username: username,
                                    email: email, password: password, avatar: "person.circle.fill", language: .english)
            let encodedUser = try Firestore.Encoder().encode(chatroomUser)
            try await Firestore.firestore().collection("users").document(chatroomUser.id).setData(encodedUser)
            print("Successfully signed up user: \(chatroomUser) ")
            
        } catch {
            print("Failed to log Create User: \(error.localizedDescription)")
        }
    }
    
    func signInWithEmailAndPassword(email: String, password: String) async throws {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            print("Successfully signed in user: \(result.user) ")
            print(auth.currentUser!.email!)
        } catch {
            print("Failed to log Create User: \(error.localizedDescription)")
        }
    }
    
    func fetchUser(completion: @escaping (User?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            completion(nil)
            return
        }
        
        Firestore.firestore().collection("users").document(uid).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = documentSnapshot, document.exists else {
                print("User document does not exist")
                completion(nil)
                return
            }
            
            do {
                if let user = try document.data(as: User?.self) {
                    completion(user)
                } else {
                    print("Error decoding user data")
                    completion(nil)
                }
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func updateUserProfile(fullname: String, username: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print("No user is signed in")
            return
        }
        let userRef = Firestore.firestore().collection("users").document(currentUser.uid)
        
        userRef.updateData(
            [
            "fullname": fullname,
            "username": username
        ]
        ) { error in
            if let error = error {
                print("Error updating Firestore user data: \(error.localizedDescription)")
            } else {
                print("Firestore user data updated successfully! : \(Firestore.firestore().collection("users").document(currentUser.uid))")
            }
        }
    }
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
