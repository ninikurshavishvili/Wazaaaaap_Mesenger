//
//  SignUpView.swift
//  Wazaaaaap_App
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = SignUpViewModel()
    @State var fullName: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isSecuredForPassword: Bool = true
    @State var isSecuredForPasswordConfirm: Bool = true
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    dismiss()
                    print("Back Button Pressed")
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(viewModel.BrandBlue)
                        .font(.title2)
                        .bold()
                }
                .padding(.leading, 10)
                
                Spacer()

                    Text("Sign Up")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .padding(.trailing, 30)
                
                Spacer()
            }
            
            viewModel.setupTextField(title: "Full Name", placeholder: "Your full name", text: $fullName)
            
            viewModel.setupTextField(title: "Username", placeholder: "Your username", text: $username)
            
            viewModel.setupTextField(title: "Email", placeholder: "Your email adress", text: $email)
            
            viewModel.setupSecuredTextField(title: "Enter Password", placeholder: "Your password", text: $password, isSecured: $isSecuredForPassword)
            
            viewModel.setupSecuredTextField(title: "Confirm Password", placeholder: "Your password", text: $confirmPassword, isSecured: $isSecuredForPasswordConfirm)
            
            Text(viewModel.errorText)
                .font(.caption)
                .foregroundStyle(.red)
                .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.signUp(fullName: fullName, username: username, email: email, password: password, confirmPassword: confirmPassword)
                
                if viewModel.isSignedIn == true {
                    dismiss()
                }
            }) {
                HStack {
                    Spacer()
                    
                    Text("Sign Up")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
                .frame(height: 65)
                .background(viewModel.BrandBlue)
                .cornerRadius(15)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    SignUpView()
}
