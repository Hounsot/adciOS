//
//  ErrorView.swift
//  AuthSUI8
//  Created by brfsu on 07.02.2024.
//
import SwiftUI

struct ErrorView: View
{
    private let successNotificationShowTime: UInt64 = 1_500_000_000
    private let errorNotificationShowTime: UInt64 = 2_800_000_000

    @Binding var errorState: ErrorState
    
    var body: some View {
        VStack {
            switch errorState {
            case .Success(let message):
                Text(message)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10).animation(.spring(dampingFraction: 0.5), value: 1)
                    .background(.green)
                    .cornerRadius(15)
                    .task(hideNotification)
            case .Error(let message):
                Text(message)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .padding(.vertical, 10).animation(.spring(dampingFraction: 0.5), value: 1)
                    .padding(.vertical, 15)
                    .background(.red)
                    .cornerRadius(15)
                    .task(hideNotification)
            case .None:
                EmptyView()
            }
            Spacer()
        }.padding(.vertical, 15)
            .padding(.horizontal, 5)
    }
    
    @Sendable private func hideNotification() async {
        switch errorState {
        case .Error: //(let message):
            try? await Task.sleep(nanoseconds: errorNotificationShowTime)
        case .Success: //(let message):
            try? await Task.sleep(nanoseconds: successNotificationShowTime)
        case .None:
            return
        }
        errorState = .None // reset state to none after sleeping
    }
}
