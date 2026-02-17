//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    init() {
        observeMessages()
    }
    
    private func observeMessages() {
        DatabaseManager.shared.observeMessages { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let messages):
                    self?.messages = messages
                case .failure(let error):
                    print("Error observing messages: \(error)")
                }
            }
        }
    }
    
    func sendMessage(text: String, completion: @escaping (Bool) -> Void) {
        guard let user = AuthManager.shared.getCurrentUser() else { return }
        
        let message = Message(userUid: user.uid, text: text, photoUrl: user.photoURL, createdAt: Date())
        DatabaseManager.shared.sendMessageToDatabase(message: message, completion: completion)
    }
}

