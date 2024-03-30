import SwiftUI
struct FeedView: View {
    @State private var employmentOpportunities: [EmploymentOpportunity] = []
    func fetchEmploymentOpportunities(callback: @escaping ([EmploymentOpportunity]) -> Void) {
        let url = URL(string: "http://localhost:3000/api/v1/employment_opportunities.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                let employmentOpportunitiesResponse = try JSONDecoder().decode(EmploymentOpportunitiesResponse.self, from: data)
                DispatchQueue.main.async {
                    callback(employmentOpportunitiesResponse.employmentOpportunities)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    var body: some View {
        ZStack{
            VStack {
                ScrollView {
                    HStack{
                        Text("Вакансии")
                            .font(Font.custom("Suisse Intl", size: 36))
                            .lineSpacing(41.52)
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal, 25)
                    Button(action: {
                        let newOpportunity = EmploymentOpportunity(companyName: "New Company", conditions: "New Conditions", createdAt: "New Date", description: "New Description", id: 120, location: "New Location", salary: "New Salary", title: "New Opportunity", updatedAt: "New Update Date", url: "New URL", vacancyType: "New Vacancy Type", workEnvironment: "New Work Environment")
                        guard let encodedData = try? JSONEncoder().encode(newOpportunity) else {
                            print("Failed to encode newOpportunity")
                            return
                        }
                        let url = URL(string: "http://localhost:3000/api/v1/employment_opportunities.json")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        let jwt = UserDefaults.standard.string(forKey: "jwt")
                        guard jwt != nil else {
                            print("JWT token is not present in UserDefaults")
                            return
                        }
                        request.addValue(jwt!, forHTTPHeaderField: "Authorization")
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.httpBody = encodedData
                        
                        URLSession.shared.dataTask(with: request) { data, response, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            if let httpResponse = response as? HTTPURLResponse {
                                print("Received response with status code: \(httpResponse.statusCode)")
                            }
                        }.resume()
                    }) {
                        Text("Опубликовать Вакансию")
                            .frame(width: 300, alignment: .center)
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.31, green: 0.91, blue: 0.36), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.28, green: 0.91, blue: 0.81), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0, y: 0),
                                    endPoint: UnitPoint(x: 1, y: 1)
                                )
                            ).cornerRadius(10)
                    }
                    VStack(alignment: .leading, spacing: 20){
                        ForEach(employmentOpportunities, id: \.self) { opportunity in
                            VStack(alignment: .leading, spacing: 25) {
                                HStack(spacing: 5) {
                                    Text(opportunity.companyName ?? "No company name")
                                        .font(Font.custom("Suisse Intl", size: 14).weight(.medium))
                                        .lineSpacing(16.80)
                                        .foregroundColor(.white)
                                    VStack(spacing: 0) {
                                        Ellipse()
                                            .foregroundColor(.clear)
                                            .frame(width: 6, height: 6)
                                            .background(Color(red: 0.56, green: 0.56, blue: 0.57))
                                            .cornerRadius(50.0)
                                    }
                                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                                    Text("3 часа назад")
                                        .font(Font.custom("Suisse Intl", size: 14))
                                        .lineSpacing(16.80)
                                        .foregroundColor(.white)
                                        .opacity(0.50)
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack{
                                        Text(opportunity.title ?? "No title")
                                            .font(Font.custom("Suisse Intl", size: 24).weight(.medium))
                                            .lineSpacing(25.68)
                                            .foregroundColor(Color(red: 0.98, green: 1, blue: 0.98))
                                        Spacer()
                                    }
                                    HStack(spacing: 4) {
                                        Text("\(opportunity.location ?? "No location"), \(opportunity.workEnvironment ?? "No work environment")")                                            .font(Font.custom("Suisse Intl", size: 14))
                                            .lineSpacing(16.80)
                                            .foregroundColor(.white)
                                            .opacity(0.50)
                                    }
                                }
                                HStack(spacing: 15) {
                                    HStack(spacing: 10) {
                                        Text(opportunity.salary ?? "No salary")
                                            .font(Font.custom("Suisse Intl", size: 12))
                                            .foregroundColor(.white)
                                    }
                                    .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                                    .background(Color(red: 0.24, green: 0.24, blue: 0.26))
                                    .cornerRadius(4)
                                    HStack(spacing: 10) {
                                        Text(opportunity.vacancyType ?? "No vacancyType")
                                            .font(Font.custom("Suisse Intl", size: 12))
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(
                                        Group {
                                            if opportunity.vacancyType == "full-time" {
                                                Color(red: 0.31, green: 0.91, blue: 0.36)
                                            } else if opportunity.vacancyType == "part-time" {
                                                Color(red: 0.28, green: 0.91, blue: 0.81)
                                            } else if opportunity.vacancyType == "intern" {
                                                Color(red: 0.57, green: 1.0, blue: 0.22)
                                            } else {
                                                Color.gray
                                            }
                                        }
                                    )
                                    .cornerRadius(4)
                                }
                            }
                            .padding(20)
                            .frame(width: 337, height: 206)
                            .background(Color(red: 0.12, green: 0.12, blue: 0.14))
                            .cornerRadius(16)
                        }
                    }.padding(0)
                }.onAppear {
                    fetchEmploymentOpportunities { fetchedOpportunities in
                        employmentOpportunities = fetchedOpportunities
                    }
                }
            }
        }.background(Color(red: 0.05, green: 0.05, blue: 0.05))
        
    }
}
