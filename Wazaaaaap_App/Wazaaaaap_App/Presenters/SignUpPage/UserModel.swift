//
//  UserModel.swift
//  Wazaaaaap_App
//
//  Created by koba Sinauridze on 22.12.24.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: String
    var fullname: String
    var username: String
    let email: String
    let password: String
    var avatar: String?
    var language: Language?
    
    init(id: String, fullname: String, username: String, email: String, password: String, avatar: String? = nil, language: Language? = nil) {
        self.id = id
        self.fullname = fullname
        self.username = username
        self.email = email
        self.password = password
        self.avatar = avatar
        self.language = language
    }

}
enum Language: String, CaseIterable, Codable {
    case georgian = "ქართული"
    case english = "English"
}
