//
//  MainScreen.swift
//  AuthSUI8
//  Created by brfsu on 14.02.2024.
//
import SwiftUI

struct MainS: View
{
    @StateObject private var viewModel = AuthViewModel()
    @Binding var errorState: ErrorState
    @State private var authorized = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Authorized user windows. Press to logout").onTapGesture {
                    UserDefaults.standard.setValue(false, forKey: "isAuth")
                    errorState = .Success(message: "Successfully signed out.")
                    dismiss()
                }
            }
        }
        .padding()
        .onReceive(viewModel.$errorState) { newState in
            if case .Success(_) = errorState {
                if case .None = newState {
                    return
                }
            }
            withAnimation {
                errorState = newState
            }
        }
    }
}
