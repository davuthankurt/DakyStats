//
//  StandingsCellPresentation.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 24.10.2024.
//

import Foundation

final class StandingsCellPresentation: NSObject {
    
    var rank: Int
    var points: Int
    var team: String
    var goalsDiff: Int
    var gamesPlayed: Int
    
    init(rank: Int, points: Int, team: String, goalsDiff: Int, gamesPlayed: Int) {
        self.rank = rank
        self.points = points
        self.team = team
        self.goalsDiff = goalsDiff
        self.gamesPlayed = gamesPlayed
    }
}
