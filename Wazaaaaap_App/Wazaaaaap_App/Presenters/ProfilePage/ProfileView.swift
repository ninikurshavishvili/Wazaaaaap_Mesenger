//
//  ProfileView.swift
//  Wazaaaaap_App
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    @State var showSignIn = false
    @State var fullName: String = ""
    @State var username: String = ""
    
    var body: some View {
        ZStack {Color(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 81 / 255, green: 89 / 255, blue: 246 / 255))
                            .frame(width: 25, height: 35)
                    }
                    
                    Spacer()
                    
                    Text("Your profile")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.black)
                        .padding(.leading, 45)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.updateUserInfo(fullname: fullName, username: username)
                    }) {
                        Text("Save")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 81 / 255, green: 89 / 255, blue: 246 / 255))
                            .padding()
                            .background(Color("BrandPrimary"))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .background(Color("Surface1"))
                .frame(height: 52)
                
                ZStack {
                    Image(viewModel.user?.avatar ?? "")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    Button(action: {
                    }) {
                        Image("pfpIcon")
                            .foregroundColor(.white)
                            .frame(width: 120, height: 120)
                            .background(Color.black.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .offset(x: 0, y: 0)
                }.padding(.leading, 4)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Full name")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    TextField("Enter New Name", text: $fullName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 0.3)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Username")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    TextField("Enter New Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 0.3)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                
                Text("Language")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                HStack {
                    ForEach(Language.allCases, id: \.self) { language in
                        Button(action: {
                            viewModel.updateLanguage(to: language)
                        }) {
                            Text(language.rawValue)
                                .padding()
                                .frame(width: 120, height: 55)
                                .background(
                                    viewModel.user?.language == language
                                    ? Color(red: 81 / 255, green: 89 / 255, blue: 246 / 255)
                                    : Color.white
                                )
                                .foregroundColor(
                                    viewModel.user?.language == language
                                    ? .white
                                    : .black
                                )
                                .cornerRadius(10)
                        }.padding()
                    }
                }
                .padding(.top, -25)
                Spacer()
                
                Button(action: {
                    viewModel.logout()
                    showSignIn = true
                }) {
                    Text("Log out")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 130, height: 40)
                        .background(Color.red)
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showSignIn, onDismiss: nil) {
            LoginView()
        }
    }
}
