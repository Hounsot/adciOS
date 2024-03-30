import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Binding var errorState: ErrorState
    @Environment(\.dismiss) var dismiss
    @State private var user: User?
    
    var body: some View {
        VStack {
            if let user = user {
                Text("Hello, \(user.name ?? "User")!")
                    .font(.title)
                    .padding()
                
                // Other profile details here
                
                Button(action: {
                    UserDefaults.standard.setValue(false, forKey: "isAuth")
                    errorState = .Success(message: "Successfully signed out.")
                    dismiss()
                }) {
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            } else {
                Text("Loading...")
            }
        }
.onAppear {
    viewModel.fetchUserData { fetchedUsers in
        if let fetchedUser = fetchedUsers.first(where: { $0.email == "user_1@email.com" }) {
            self.user = fetchedUser
        }
    }
}}}
