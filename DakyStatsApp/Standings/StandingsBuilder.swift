//
//  StandingsBuilder.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 27.09.2024.
//

import UIKit

final class StandingsBuilder {

    static func make(with viewModel: StandingsViewModelProtocol) -> StandingsViewController {

        let viewController = StandingsViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
