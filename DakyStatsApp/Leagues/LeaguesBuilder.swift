//
//  LeaguesBuilder.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 13.09.2024.
//

import UIKit

final class LeaguesBuilder {

    static func make() -> LeaguesViewController {

        let viewController = LeaguesViewController()
        viewController.viewModel = LeagueViewModel(service: app.service) 
        return viewController
    }
}
