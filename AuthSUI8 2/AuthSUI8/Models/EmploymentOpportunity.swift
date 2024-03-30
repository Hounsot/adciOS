//
//  EmploymentOpportunity.swift
//  AuthSUI8
//
//  Created by m.vasillyev on 30.03.2024.
//

import Foundation
struct EmploymentOpportunity: Encodable, Hashable, Decodable, Identifiable {
    let companyName: String?
    let conditions: String?
    let createdAt: String?
    let description: String?
    let id: Int?
    let location: String?
    let salary: String?
    let title: String?
    let updatedAt: String?
    let url: String?
    let vacancyType: String?
    let workEnvironment: String?
    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case conditions
        case createdAt
        case description
        case id
        case location
        case salary
        case title
        case updatedAt
        case url
        case vacancyType = "vacancy_type"
        case workEnvironment = "work_environment"
    }
}
