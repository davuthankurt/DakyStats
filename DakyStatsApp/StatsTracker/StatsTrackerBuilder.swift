//
//  StatsTrackerBuilder.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 29.10.2024.
//

import Foundation

final class StatsTrackerBuilder {
    static func make() -> StatsTrackerViewController {
        let viewController = StatsTrackerViewController()
        viewController.viewModel = StatsTrackerViewModel(service: app.service)
        return viewController
    }
}
