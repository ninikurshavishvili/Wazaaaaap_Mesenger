//
//  Message.swift
//  ChatApp
//
//  Created by Nino Kurshavishvili on 21.12.24.
//

import SwiftUI

struct Message: Decodable, Identifiable, Equatable {
    var id = UUID()
    let userUid: String
    let text: String
    let photoUrl: String?
    let createdAt: Date
    
    func isFromCurrentUser() -> Bool {
        guard let curretUser = AuthManager.shared.getCurrentUser() else {
            return false
        }
        if curretUser.uid == userUid {
            return true
        } else {
            return false
        }
    }
    
}
