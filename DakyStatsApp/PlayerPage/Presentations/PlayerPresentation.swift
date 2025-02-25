//
//  PlayerPresentation.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import Foundation
import StatsAPI

final class PlayerPresentation: NSObject {
    let player: Player
    let statistics: [Statistics]
    
    init(player: Player, statistics: [Statistics]) {
        self.player = player
        self.statistics = statistics
    }
}
