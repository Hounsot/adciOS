//
//  AuthScreen.swift
//  AuthSUI8
//  Created by brfsu on 14.02.2024.
//
import SwiftUI

struct AuthS: View
{
//    @StateObject private var viewModel = AuthViewModel()
//    @Binding var navigationState: NavigationState
//    @Binding var errorState: ErrorState
//    @State private var username = ""
//    @State private var password = ""
//    @State private var email = ""
//    @State private var secretResponse = ""
//    @State private var isLoginEnabled = true
//    @State private var isPasswordVisible = false
    
    var body: some View {
/*
        NavigationView {
            // Text("!!!")
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 20) {
                    
                    // Login screen
                    if viewModel.showLogin {
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle()).onAppear {
                                username = ""
                                password = ""
                                secretResponse = ""
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
                        
                        // Login button
                        Button {
                            let body: [String: Any] = [
                                "username": username,
                                "password": password
                            ]
//                            viewModel.postRequest(endpoint: "signin", body: body, callback: (String) -> Void)
                            
                        } label: {
                            Text("Login")
                                .font(.system(size: 25, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                                }
                        }.disabled(!isLoginEnabled).onReceive(viewModel.$loginCounter) {
                            counter in
                            if (counter == 3) {
                                isLoginEnabled = false
                            } else {
                                isLoginEnabled = true
                            }
                        }
                        
                        // Reset button
                        Button {
                            viewModel.showReset = true
                            viewModel.showLogin = false
                        } label: {
                            Text("Reset password")
                                .font(.system(size: 25, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                                }
                        }
                    }
                    
                    // Reset password and registration screen
                    if (viewModel.showRegister || viewModel.showReset) {
                        TextField("User name", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle()).onAppear {
                                username = ""
                                password = ""
                                email = ""
                                secretResponse = ""
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
                        
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Response on the secret question", text: $secretResponse)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        // Defining registration button
                        if (viewModel.showRegister) {
                            Button {
                                let body: [String: Any] = [
                                    "username": username,
                                    "password": password,
                                    "email": email,
                                    "secretResponse": secretResponse
                                ]
//                                viewModel.postRequest(endpoint: "signup", body: body)
                            } label: {
                                Text("Register")
                                    .font(.system(size: 25, weight: .bold))
                                    .frame(width: 200, height: 50)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                                    }
                            }
                        }
                        
                        //
                        if (viewModel.showReset) {
                            Button {
                                let body: [String: Any] = [
                                    "username": username,
                                    "password": password,
                                    "email": email,
                                    "secretResponse": secretResponse
                                ]
//                                viewModel.postRequest(endpoint: "reset", body: body)
                            } label: {
                                Text("Reset")
                                    .font(.system(size: 25, weight: .bold))
                                    .frame(width: 200, height: 50)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                                    }
                            }
                        }
                        
                    }
                    
                    if (viewModel.showLogin || viewModel.showRegister || viewModel.showReset) {
                        Button {
                            viewModel.showLogin = false
                            viewModel.showRegister = false
                            viewModel.showReset = false
                        } label: {
                            Text("Back")
                                .font(.system(size: 25, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                    } else {
                        // Main auth screen
                        Button {
                            viewModel.showLogin = true
                        } label: {
                            Text("Login")
                                .font(.system(size: 25, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            viewModel.showRegister = true
                        } label: {
                            Text("Register")
                                .font(.system(size: 25, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                                }
                        }
                    }
                }
                .padding().onReceive(viewModel.$isSuccessAuth) {
                    isSuccess in
                    if isSuccess == true {
                        print("Auth finished")
                        navigationState = .Main
                    }
                }
            }
            .navigationTitle("Auth")
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
        }.onTapGesture {
            endEditing()
        }
        
        */
        Text("")
    }
    
//    private func endEditing() {
//        UIApplication.shared.endEditing()
//    }
}
