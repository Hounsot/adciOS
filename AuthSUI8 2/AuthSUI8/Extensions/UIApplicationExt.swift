//
//  UIApplicationExt.swift
//  AuthSUI8
//  Created by brfsu on 28.02.2024.
//
import SwiftUI

extension UIApplication
{
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
