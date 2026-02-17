//
//  ChatView.swift
//  WazaaaaapApp
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State private var text = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollViewProxy in
                    VStack {
                        ForEach(chatViewModel.messages) { message in
                            MessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: chatViewModel.messages, initial: false) {
                        if let lastMessage = chatViewModel.messages.last {
                            scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            .padding(.top, 8)
            
            HStack {
                TextField("Reply to everyone...", text: $text, axis: .vertical)
                    .font(.system(size: 16))
                    .padding(.vertical, 8)
                    .padding(.leading, 12)
                    .background(Color(red: 241/255, green: 242/255, blue: 246/255))
                    .cornerRadius(20)
                    .padding(.leading, 12)
                
                Button {
                    sendMessage()
                } label: {
                    Image("sendButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 20)
                        .padding()
                }
                .frame(width: 34, height: 34)
                .background(Color(red: 81/255, green: 89/255, blue: 246/255))
                .clipShape(Circle())
                .padding(.trailing, 9)
            }
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }
    
    private func sendMessage() {
        guard !text.isEmpty else { return }
        chatViewModel.sendMessage(text: text) { success in
            if success {
                text = ""
            } else {
                print("Failed to send message.")
            }
        }
    }
}

#Preview {
    ChatView()
}

