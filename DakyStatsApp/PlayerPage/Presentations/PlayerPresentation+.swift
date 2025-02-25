//
//  PlayerPresentation+.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import Foundation
import StatsAPI

extension PlayerPresentation {
    convenience init(footballer: PlayerInfo) {
        self.init(player: footballer.player, statistics: footballer.statistics)
    }
}
