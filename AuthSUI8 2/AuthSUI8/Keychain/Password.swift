//
//  Password.swift
//  AuthSUI8
//  Created by brfsu on 14.02.2024.
//
import Foundation

// Keys for keychain to save bearer token
let account = "su.brf.apps.AuthSUI8"

struct BearerToken: Codable {
    let bearerToken: String
}
