//
//  AuthViewModel.swift
//  AuthSUI8
//  Created by brfsu on 14.02.2024.
//
import Foundation

class AuthViewModel: ObservableObject
{
    private let successLoginMessage = "You have successfully logged in."
    @Published var showLogin = false
    @Published var showRegister = false
    @Published var showReset = false
    @Published var isSuccessAuth = false
    @Published var errorState: ErrorState = .None
    @Published var loginCounter = 0
    @Published var token = ""
    
    init() {
        if (UserDefaults.standard.bool(forKey: "isAuth")) {
            isSuccessAuth = true
        }
        print("!!!!!!!!!!!!!!")
        print(isSuccessAuth)
    }
    private func validatePassword(password: String) -> Bool {
        let control = #"(?=.{8,})(?=.*[0-9a-zA-Z])(?=.*[!#$%&? "])"#
        if password.range(of: control, options: .regularExpression) != nil {
            print("true!")
            return true
        }
        print("false!")
        return false
        //        return true
    }
    
func fetchUserData(callback: @escaping ([User]) -> Void) {
    let url = URL(string: "http://localhost:3000/api/v1/user")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let jwt = UserDefaults.standard.string(forKey: "jwt")
    request.addValue(jwt!, forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if let data = data {
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    callback(users)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }.resume()
}    // Server post request // for signin, signup and reset password
    func postRequest(endpoint: String, body: [String: Any], callback: @escaping (String) -> Void, _ requestType: String = "POST") {
        self.token = ""
        let url = URL(string: "http://localhost:3000/api/v1/\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Received response with status code: \(httpResponse.statusCode)")
            }
            guard let data = data else {
                print("No data received from server or data is unreadable.")
                return
            }
            let rawDataString = String(data: data, encoding: .utf8)
            print("Raw data from server: \(rawDataString ?? "No data")")
            do {
                let authResponse = try JSONDecoder().decode(RegLogResponse.self, from: data)
                if authResponse.jwt.isEmpty {
                    DispatchQueue.main.async {
                        self.errorState = .Error(message: "JWT is empty.")
                    }
                    return
                } else {
                    // JWT received
                    self.errorState = .Success(message: "Successful.")
                    UserDefaults.standard.setValue(authResponse.jwt, forKey: "jwt")
                    self.isSuccessAuth = true
                    self.token = authResponse.jwt
                    callback(self.token)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
