//
//  User.swift
//  AuthSUI8
//
//  Created by m.vasillyev on 30.03.2024.
//

import Foundation
struct User: Codable {
    let id: Int
    let email: String
    let admin: Bool
    let created_at: String
    let updated_at: String
    let name: String?
    let surname: String?
    let jti: String
    let profilePicture: ProfilePicture?
    let role: String?
}

struct ProfilePicture: Codable {
    let url: String?
}
