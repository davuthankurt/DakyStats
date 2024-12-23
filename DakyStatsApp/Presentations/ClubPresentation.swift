//
//  ClubPresentation.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 13.10.2024.
//

import UIKit
import StatsAPI

final class ClubPresentation: NSObject {
    let team: Team
    let players: [Players]
    
    init(team: Team, players: [Players]) {
        self.team = team
        self.players = players
    }
}
