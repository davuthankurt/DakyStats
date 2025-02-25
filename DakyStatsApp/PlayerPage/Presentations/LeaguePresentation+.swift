//
//  LeaguePresentation+.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 14.09.2024.
//

import Foundation
import StatsAPI

extension LeaguePresentation {
    convenience init(league: League) {
        self.init(title: league.name, image: league.logo)
    }
}
