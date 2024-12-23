//
//  Team.swift
//  StatsAPI
//
//  Created by Davuthan Kurt on 11.10.2024.
//

import Foundation

public struct Clubs: Codable {
    public let team: Team
    public let players: [Players]
    
}

public struct Players: Codable {
    public let id: Int
    public let name: String?
    public let age: Int?
    public let number: Int?
    public let position: String?
    public let photo: String?
}

