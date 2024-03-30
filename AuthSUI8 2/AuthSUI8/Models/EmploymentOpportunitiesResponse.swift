//
//  EmploymentOpportunitiesResponse.swift
//  AuthSUI8
//
//  Created by m.vasillyev on 30.03.2024.
//

import Foundation
struct EmploymentOpportunitiesResponse: Decodable {
    let createUrl: String
    let employmentOpportunities: [EmploymentOpportunity]

    enum CodingKeys: String, CodingKey {
        case createUrl = "create_url"
        case employmentOpportunities = "employment_opportunities"
    }
}
