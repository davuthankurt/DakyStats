//
//  League.swift
//  FootballStatsAPI
//
//  Created by Davuthan Kurt on 6.09.2024.
//


import Foundation


public struct League: Codable {
    public let name: String
    public let logo: String
    public let standings: [[Standing]]
}

public struct Standing: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case rank
        case form
        case points
        case team
        case records = "all"
        case goalsDiff
    }
    public let rank: Int
    public let form: String?
    public let points: Int
    public let team: Team
    public let records: Record
    public let goalsDiff: Int
}

public struct Team: Codable {
    public let name: String
    public let logo: String
    public let id: Int
}

public struct Record: Codable {
    public let win: Int
    public let draw: Int
    public let lose: Int
}
