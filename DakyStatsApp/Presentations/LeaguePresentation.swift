//
//  LeaguePresentation.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 14.09.2024.
//

import UIKit
import StatsAPI
final class LeaguePresentation: NSObject {
    let title: String
    let image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
        super.init()
    }
}



