//
//  LeagueResponse.swift
//  FootballStatsAPI
//
//  Created by Davuthan Kurt on 7.09.2024.
//

import Foundation


public struct LeagueResponse: Codable {
    
    private enum RootCodingKeys: String, CodingKey {
        case response
    }
    
    private enum ResponseCodingKeys: String, CodingKey {
        case league
    }
    
    public let results: [League]
    
    init(results: [League]) {
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let responseArray = try rootContainer.decode([ResponseWrapper].self, forKey: .response)
        self.results = responseArray.map { $0.league }
    }
}

private struct ResponseWrapper: Codable {
    let league: League
}

