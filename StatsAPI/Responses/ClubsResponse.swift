//
//  ClubsResponse.swift
//  StatsAPI
//
//  Created by Davuthan Kurt on 15.10.2024.
//

import Foundation

public struct ClubsResponse: Codable {
    private enum RootCodingKeys: String, CodingKey {
        case response
    }
    
    public let results: [Clubs]
    
    init(results: [Clubs]) {
        self.results = results
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Clubs].self, forKey: .response)
    }
    
}
