//
//  PlayerResponse.swift
//  StatsAPI
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import Foundation

public struct PlayerResponse: Codable {
    private enum RootCodingKeys: String, CodingKey {
        case response
    }
    
    public let response: [PlayerInfo]
    
    init(response: [PlayerInfo]) {
        self.response = response
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.response = try container.decode([PlayerInfo].self, forKey: .response)
    }
}
