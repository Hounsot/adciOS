//
//  KeychainHelper.swift
//  AuthSUI8
//  Created by brfsu on 14.02.2024.
//
import Foundation

final class KeychainHelper
{
    static let shared = KeychainHelper()
    
    private init() {}
    
    // MARK: - Save and Update
    
    // Save data to keychain
    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString : Any] as CFDictionary
        
        // Add or update item in keychain
        var status = SecItemAdd(query, nil)
        
        // Check if item already exists or needs to be updated
        if status == errSecDuplicateItem || status == -25299 {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
            ] as [CFString : Any] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            status = SecItemUpdate(query, attributesToUpdate)
        }
        
        // Check if there was an error during save/update operation
        if status != errSecSuccess || status != 0 {
            print("Error: \(status)")
        }
    }
    
    // MARK: - Read
    
    // Read data from keychain
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as [CFString : Any] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    // Delete data from keychain
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as [CFString : Any] as CFDictionary
        SecItemDelete(query)
    }
        
    // MARK: - Save Codable
    
    // Save Codable item to Keychain
    func save<T>(_ item: T, service: String, account: String) throws where T: Codable {
        let data = try JSONEncoder().encode(item)
        save(data, service: service, account: account)
    }
    
    // Read Codable item from Keychain
    func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable {
        guard let data = read(service: service, account: account) else {
            return nil
        }
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain")
            return nil
        }
    }
}
