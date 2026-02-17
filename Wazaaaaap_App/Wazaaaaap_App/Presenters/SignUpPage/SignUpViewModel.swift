//
//  SignUpViewModel.swift
//  Wazaaaaap_App
//
//  Created by koba Sinauridze on 22.12.24.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    
    let BrandBlue = Color(red: 81/255, green: 89/255, blue: 246/255, opacity: 1)
    let textColor = Color(red: 94/255, green: 99/255, blue: 102/255, opacity: 1)
    @Published var isSignedIn: Bool = false
    @Published var errorText = ""
    
    func setupTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(textColor)
            
            TextField("", text: text, prompt: Text(placeholder)
                .foregroundColor(textColor)
            )
            .foregroundColor(textColor)
            .padding(.leading)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(textColor, lineWidth: 1)
            )
        }
        .padding(.horizontal,20)
        .padding(.top, 10)
    }
    
    func setupSecuredTextField(title: String, placeholder: String, text: Binding<String>, isSecured: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(textColor)
            
            ZStack(alignment: .leading) {
                Image(systemName: "lock")
                    .accentColor(textColor)
                    .padding(.leading, 10)
                
                ZStack(alignment: .trailing) {
                    Button(action: {
                        isSecured.wrappedValue.toggle()
                    }) {
                        Image(systemName: isSecured.wrappedValue ? "eye.slash" : "eye")
                            .accentColor(textColor)
                    }
                    .padding(.trailing, 10)
                    
                    Group {
                        if isSecured.wrappedValue {
                            SecureField("", text: text, prompt: Text(placeholder).foregroundColor(textColor))
                        } else {
                            TextField("", text: text, prompt: Text(placeholder).foregroundColor(textColor))
                        }
                    }
                    .padding(.trailing, 38)
                    .padding(.leading, 20)
                    .foregroundColor(textColor)
                    .padding(.leading)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(textColor, lineWidth: 1)
                    )
                }
            }
        }
        .padding(.horizontal,20)
        .padding(.top, 10)
    }
    
    func signUp(fullName: String, username: String, email: String, password: String, confirmPassword: String) {
        if fullName == "" || username == "" || email == "" || password == "" || confirmPassword == "" {
            errorText = "Please Fill All The Forms"
            print(errorText)
        } else if password.count < 6 {
            errorText = "The Password Must Be 6 Characters Long Or More"
            print(errorText)
        } else if !email.contains("@") || !email.contains(".com") {
            errorText = "The Email Address Is Incorrect"
            print(errorText)
        } else if password != confirmPassword {
            errorText = "Confirm Passowrd Doesn't Match"
            print(errorText)
        } else {
            Task {
                try await AuthManager.shared.signUpWithEmailAndPassword(email: email, password: password, fullname: fullName, username: username)
            }
            errorText = ""
            isSignedIn = true
        }
    }
}
