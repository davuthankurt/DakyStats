//
//  File.swift
//  StatsAPI
//
//  Created by Davuthan Kurt on 22.10.2024.
//

import Foundation

public struct PlayerInfo: Codable {
    public let player: Player
    public let statistics: [Statistics]
}

public struct Player: Codable {
    public let id: Int
    public let name: String?
    public let firstname: String?
    public let lastname: String?
    public let age: Int?
    public let nationality: String?
    public let height: String?
    public let weight: String?
    public let photo: String?
}

public struct Statistics: Codable {
    public let team: Team
    public let league: League
    public let games: Games
    public let goals: Goals
    public let cards: Cards
    
    public struct League: Codable {
        public let country: String?
        public let flag: String?
        public let id: Int?
        public let logo: String?
        public let name: String?
    }
}

public struct Games: Codable {
    public let appearences: Int?
    public let lineups: Int?
    public let minutes: Int?
    public let rating: String?
}

public struct Goals: Codable {
    public let total: Int?
    public let assists: Int?
}

public struct Cards: Codable {
    public let yellow: Int?
    public let red: Int?
}


