//
//  StandingsPresentation+.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 1.10.2024.
//

import Foundation
import StatsAPI

extension StandingsPresentation {
    
    convenience init(league: League) {
        self.init(standings: league.standings)
    }
}
