//
//  ProfileViewModel.swift
//  Wazaaaaap_App
//
//  Created by Anna Harris on 23.12.24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    
    @Published var isLoggedOut = false
    
    func updateAvatar(with newImage: String) {
        user?.avatar = newImage
    }
    
    func updateLanguage(to newLanguage: Language) {
        user?.language = newLanguage
    }
    
    func logout() {
        do {
            try AuthManager.shared.signOut()
            print("Successfully signed out.")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        isLoggedOut = true
    }
    
    func getUserFullname() -> String? {
        let user = AuthManager.shared.getCurrentUser()
        return user?.name
    }
    
    func updateUserInfo(fullname: String, username: String) {
        AuthManager.shared.updateUserProfile(fullname: fullname, username: username)
    }
}
