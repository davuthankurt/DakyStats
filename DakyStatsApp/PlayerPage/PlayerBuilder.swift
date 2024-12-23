//
//  PlayerBuilder.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import Foundation

final class PlayerBuilder {
    static func make(playerId: Int) -> PlayerViewController {
        let viewController = PlayerViewController()
        viewController.viewModel = PlayerViewModel(service: app.service, playerId: playerId)
        return viewController
    }
}
