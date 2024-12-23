//
//  StandingsCellPresentation+.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 24.10.2024.
//

import Foundation
import StatsAPI

extension StandingsCellPresentation {
    convenience init(team: Standing) {
        self.init(rank: team.rank, points: team.points, team: team.team.name, goalsDiff: team.goalsDiff, gamesPlayed: team.records.draw + team.records.lose + team.records.win)
    }
}
