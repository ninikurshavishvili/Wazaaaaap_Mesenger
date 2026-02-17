//
//  LoginView.swift
//  Wazaaaaap_App
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct LoginView: View {
    @State var showSignIn = false
    @StateObject private var viewModel = LoginViewModel()
    @State private var isShowingSignUp = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Wazaaaaap")
                .font(.custom("Pacifico-Regular", size: 48))
                .foregroundColor(Color(red: 81/255, green: 89/255, blue: 246/255))
                .padding(.leading, -10)

            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                Text("Email")
                    .font(.system(size: 12))
                    .padding(.leading, 1)

                TextField("Your email address", text: $viewModel.email)
                    .padding()
                    .frame(width: 327, height: 52)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                Text("Password")
                    .font(.system(size: 12))
                    .padding(.leading, 1)

                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                        .padding(.leading, 15)

                    if viewModel.isPasswordVisible {
                        TextField("Enter your password", text: $viewModel.password)
                            .padding(.vertical, 12)
                    } else {
                        SecureField("Enter your password", text: $viewModel.password)
                            .padding(.vertical, 12)
                    }

                    Button(action: {
                        viewModel.isPasswordVisible.toggle()
                    }) {
                        Image(systemName: viewModel.isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                .frame(width: 327, height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )

                HStack {
                    Text("New To Wazaaaaap?")
                        .font(Font.custom("Inter", size: 12).weight(.regular))
                        .foregroundColor(Color(red: 94/255, green: 99/255, blue: 102/255))
                        .padding(.leading, -10)

                    Spacer()

                    Button(action: {
                        isShowingSignUp = true
                    }) {
                        Text("Sign Up")
                            .font(Font.custom("Anek Devanagari", size: 18).weight(.bold))
                            .foregroundColor(Color(red: 94/255, green: 99/255, blue: 102/255))
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, 32)

            Spacer()

            VStack(spacing: 10) {
                Button(action: {
                    AuthManager.shared.signInWithGoogle { result in
                        switch result {
                        case .success(_):
                            showSignIn = true
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }) {
                    HStack {
                        Image("GoogleLogo")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Continue with Google")
                            .font(.custom("Roboto", size: 20).weight(.medium))
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 327, height: 64)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .padding(.top, 30)

                Button(action: {
                    viewModel.login()
                    showSignIn = true
                }) {
                    Text("Log in")
                        .font(.system(size: 18))
                        .frame(width: 327, height: 64)
                        .background(Color(red: 81/255, green: 89/255, blue: 246/255))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }

            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("შეცდომა!"), message: Text("არასწორი ინფორმაცია"), dismissButton: .default(Text("გასაგებია")))
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: $showSignIn, onDismiss: nil) {
            ContentView()
        }
        .fullScreenCover(isPresented: $isShowingSignUp, onDismiss: nil) {
            SignUpView()
        }
    }
}
