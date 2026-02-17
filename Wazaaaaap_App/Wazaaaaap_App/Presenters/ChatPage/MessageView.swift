//
//  MessageView.swift
//  ChatApp
//
//  Created by Nino Kurshavishvili on 21.12.24.
//
import SwiftUI

struct MessageView: View {
    var message: Message
    @State private var showReactions = false
    @State private var selectedReaction: String?

    var body: some View {
        VStack(alignment: message.isFromCurrentUser() ? .trailing : .leading) {
            HStack {
                if message.isFromCurrentUser() {
                    Spacer()
                    messageBubble
                        .onLongPressGesture {
                            withAnimation {
                                showReactions.toggle()
                            }
                        }
                } else {
                    messageBubble
                        .onLongPressGesture {
                            withAnimation {
                                showReactions.toggle()
                            }
                        }
                    Spacer()
                }
            }
            if showReactions {
                reactionPopUp
                    .transition(.scale)
            }
        }
    }

    private var messageBubble: some View {
        Group {
            if message.isFromCurrentUser() {
                HStack {
                    Text(message.text)
                        .font(.system(size: 16))
                        .padding(.vertical, 9)
                        .foregroundColor(Color(red: 17/255, green: 21/255, blue: 57/255))
                        .padding(.horizontal, 12)
                        .background(Color(red: 227/255, green: 231/255, blue: 255/255))
                        .cornerRadius(16)
                        .overlay(
                            selectedReaction.map { reaction in
                                Text(reaction)
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color.clear)
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                                    .offset(x: message.isFromCurrentUser() ? -8 : 8, y: 10)
                            }
                        )
                }
                .frame(alignment: .trailing)
                .padding(.trailing, 12)
                .padding(.leading, 101)
            } else {
                HStack(alignment: .top) {
                    profileImage
                    
                    VStack(alignment: .leading) {
                        Text("@givi")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(red: 81/255, green: 89/255, blue: 246/255))
                        
                        VStack(alignment: .trailing) {
                            Text(message.text)
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 17/255, green: 21/255, blue: 57/255))
                                .padding(.top, 2)
                                .padding(.horizontal, 12)
                            
                            Text("10:08")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 112/255, green: 115/255, blue: 136/255))
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            selectedReaction.map { reaction in
                                Text(reaction)
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color.clear)
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                                    .offset(x: message.isFromCurrentUser() ? -8 : 8, y: 10)                            }
                        )
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color(red: 241/255, green: 242/255, blue: 246/255))
                    .cornerRadius(16)
                }
                .padding(.leading, 12)
                .padding(.trailing, 57)
            }
        }
    }

    private var profileImage: some View {
        Group {
            if let photoUrl = message.photoUrl, !photoUrl.isEmpty {
                AsyncImage(url: URL(string: photoUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.5))
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 32, height: 32)
        .clipShape(Circle())
    }

    private var reactionPopUp: some View {
        HStack(spacing: 10) {
            ForEach(["😄", "❤️", "🍻", "😭", "😈"], id: \.self) { emoji in
                Text(emoji)
                    .font(.title2)
                    .padding(8)
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 2)
                    .onTapGesture {
                        withAnimation {
                            selectedReaction = emoji
                            showReactions = false
                        }
                    }
            }
        }
        .padding(10)
        .background(Capsule().fill(Color.gray.opacity(0.2)))
        .overlay(
            Capsule()
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .padding(.top, -10)
    }
}
#Preview {
    MessageView(message: Message(userUid: "currentUserUID", text: "Hello World", photoUrl: nil, createdAt: Date()))
}

