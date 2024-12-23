//
//  StandingsPresentation.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 1.10.2024.
//

import UIKit
import StatsAPI

final class StandingsPresentation: NSObject {
    
    let standings: [[Standing]]
    
    init(standings: [[Standing]]) {
        self.standings = standings
        super.init()
    }
}
