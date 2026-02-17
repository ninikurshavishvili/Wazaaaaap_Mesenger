//
//  LoginViewModel.swift
//  Wazaaaaap_App
//
//  Created by Levan Gorjeladze on 23.12.24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var showAlert: Bool = false
    
    func login() {
        if email.isEmpty || password.isEmpty {
            showAlert = true
        } else {
            Task {
                try await AuthManager.shared.signInWithEmailAndPassword(email: email, password: password)
            }
            isLoggedIn = true
        }
    }
}
