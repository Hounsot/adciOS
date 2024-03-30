//
//  ContentView.swift
//  AuthSUI8
//  Created by brfsu on 07.02.2024.
//
import SwiftUI

struct StartS: View {
    //    @State private var navigationState: NavigationState = .Auth
    @State private var errorState: ErrorState = .None
    @State private var viewModel = AuthViewModel()
    
    var body: some View {
        TabView {
            if viewModel.isSuccessAuth {
                FeedView()
                    .tabItem {
                        Label("Feed", systemImage: "list.dash")
                    }
                ProfileView(viewModel: viewModel, errorState: $errorState)
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            } else {
                MainAuthS()
            }
        }
        .overlay (
            ErrorView(errorState: $errorState)
        )
    }
    
}
    
    
    //    switch navigationState {
    //    case .Auth:
    ////                AuthS(navigationState: $navigationState.animation(), errorState: $errorState.animation())
    //        MainAuthS()
    ////                LoginS()
    //    case .Main:
    //        MainS(errorState: $errorState) //navigationState: $navigationState.animation())
    //    }
