//
//  ContentView.swift
//  Wazaaaaap_App
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct ContentView: View {
    @State var showSignIn: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ChatView() 
            }
            .navigationTitle("Wazaaaaap")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(red: 241/255, green: 242/255, blue: 246/255))
            .toolbarBackground(.visible, for: .navigationBar)
            .overlay(
                Rectangle()
                    .fill(Color(red: 228/255, green: 230/255, blue: 238/255))
                    .frame(height: 1),
                alignment: .top)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Wazaaaaap")
                        .font(.Pacifico(size: 24))
                        .foregroundColor(Color(red: 81/255, green: 89/255, blue: 246/255))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        do {
                            try AuthManager.shared.signOut()
                            showSignIn = true
                        } catch {
                            print("error sign out")
                        }
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(Color(red: 81/255, green: 89/255, blue: 246/255))
                            .bold()
                    }
                }
            }
            .onAppear {
                showSignIn = AuthManager.shared.getCurrentUser() == nil
            }
        }
        .fullScreenCover(isPresented: $showSignIn) {
            ProfileView()
        }
    }
}

#Preview {
    ContentView()
}

