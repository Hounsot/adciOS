//
//  MainAuthS.swift
//  AuthSUI8
//  Created by brfsu on 13.03.2024.
//
import SwiftUI

struct MainAuthS: View {
    @State private var errorState: ErrorState = .None
    
    var body: some View {
        ZStack{
            NavigationView {
                VStack {
                    HStack{
                        Text("Вход")
                            .font(Font.custom("Suisse Intl", size: 36))
                            .foregroundColor(.white)
                            .padding()
                    }
                    NavigationLink(destination: SigninS(errorState: $errorState)) {
                        Text("Вход")
                    }
                    .font(Font.custom("Suisse Intl", size: 36))
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)                    }
                    
                    // Reset password button
                    NavigationLink(destination: ResetS(errorState: $errorState)) {
                        Text("Reset password")
                    }
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 200, height: 30).padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                    }
                    
                    
                    // Sign up button
                    NavigationLink(destination: SignupS(errorState: $errorState)) {
                        Text("Sign up")
                    }
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 200, height: 30).padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                    }
                    
                    
                    // Delete user account button
                    NavigationLink(destination: DropS(errorState: $errorState)) {
                        Text("Delete account")
                    }
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 200, height: 30).padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 5)
                    }
                    
                }.frame(width: 420, height: 900)
                    .background(Color(red: 0.05, green: 0.05, blue: 0.05))
            }.background(Color(red: 0.05, green: 0.05, blue: 0.05))
        }.background(Color(red: 0.05, green: 0.05, blue: 0.05))
    }
}
