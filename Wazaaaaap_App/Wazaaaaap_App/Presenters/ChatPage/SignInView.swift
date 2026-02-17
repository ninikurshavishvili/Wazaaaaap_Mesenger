//
//  SignInView.swift
//  ChatApp
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct SignInView: View {
    @Binding var showSignIn: Bool
    var body: some View {
        VStack(spacing: 60) {
            Text("Sign In")
            
            VStack {
                Button {
                    print("apple")
                } label: {
                    Text("sign in with apple")
                        .padding()
                        .foregroundStyle(.primary)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke()
                                .foregroundStyle(.primary)
                                .frame(width: 300)
                        }
                }
                .frame(width: 300)
                
                Button {
                    AuthManager.shared.signInWithGoogle { result in
                        switch result {
                        case .success(_):
                            showSignIn = false
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Text("sign in with google")
                        .padding()
                        .foregroundStyle(.primary)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke()
                                .foregroundStyle(.primary)
                                .frame(width: 300)
                        }
                }
                .frame(width: 300)
            }
        }
    }
}

#Preview {
    SignInView(showSignIn: .constant(true))
}
