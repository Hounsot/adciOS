//
//  PasswordTextField.swift
//  AuthSUI8
//  Created by brfsu on 21.02.2024.
//
import SwiftUI

struct PasswordTextField: View
{
    private var title: String
    @Binding private var text: String
    private var isSecure: Bool
    
    init(_ title: String, text: Binding<String>, isSecure: Bool) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
