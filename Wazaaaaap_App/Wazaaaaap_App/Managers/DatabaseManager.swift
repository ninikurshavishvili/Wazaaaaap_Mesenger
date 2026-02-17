//
//  DatabaseManager.swift
//  Wazaaaaap_App
//
//  Created by Nino Kurshavishvili on 22.12.24.
//

import FirebaseFirestore

enum FetchMessagesError: Error {
    case snapshotError
}

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let messageReference = Firestore.firestore().collection("message")
    
    func observeMessages(completion: @escaping (Result<[Message], FetchMessagesError>) -> Void) {
        messageReference.order(by: "createdAt", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(.snapshotError))
                    return
                }
            
            let messages = snapshot.documents.compactMap { doc -> Message? in
                let data = doc.data()
                guard let text = data["text"] as? String,
                      let userUid = data["userUid"] as? String,
                      let createdAt = data["createdAt"] as? Timestamp else {
                    return nil
                }
                let photoUrl = data["photoURL"] as? String
                return Message(userUid: userUid, text: text, photoUrl: photoUrl, createdAt: createdAt.dateValue())
            }
            
            completion(.success(messages))
        }
    }
    
    func sendMessageToDatabase(message: Message, completion: @escaping (Bool) -> Void) {
        let data: [String: Any] = [
            "text": message.text,
            "userUid": message.userUid,
            "photoURL": message.photoUrl ?? "",
            "createdAt": message.createdAt
        ]
        
        messageReference.addDocument(data: data) { error in
            completion(error == nil)
        }
    }
}

