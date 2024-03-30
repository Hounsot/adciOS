//
//  DropS.swift
//  AuthSUI8
//  Created by brfsu on 20.03.2024.
//
import SwiftUI

struct DropS: View
{
    @StateObject private var viewModel = AuthViewModel()
    @Binding var errorState: ErrorState
    
    @State private var anauthorized = false
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 20) {
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).onAppear {
                            username = ""
                            password = ""
                        }
                    PasswordTextField("Password", text: $password, isSecure: !isPasswordVisible)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay {
                            HStack {
                                Spacer()
                                Button {
                                    isPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    
                    Button {
                        let body: [String: Any] = [
                            "username": username,
                            "password": password
                        ]
                        viewModel.postRequest(endpoint: "drop", body: body, callback: { token in
                            if token.count > 100 { // токен
                                anauthorized = true
                                UserDefaults.standard.setValue(false, forKey: "isAuth")
                                errorState = .Success(message: "The user account is deleted successfully.")
//                            } else { // ошибка
//                                errorState = .Error(message: "Error.")
                            }
                        }, "DELETE")
                    } label: {
                        Text("Delete")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    // go back
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: 200, height: 40)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .navigate(to: StartS(), when: $anauthorized)
                
            }.padding()
        }
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
        .navigationTitle("Delete user account")
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
}
