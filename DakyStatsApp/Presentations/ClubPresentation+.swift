//
//  ClubPresentation+.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 13.10.2024.
//

import Foundation
import StatsAPI

extension ClubPresentation {
    convenience init(club: Clubs) {
        self.init(team: club.team, players: club.players)
    }
}
