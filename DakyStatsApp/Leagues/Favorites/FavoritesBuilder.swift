//
//  FavoritesBuilder.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 6.12.2024.
//

import Foundation

final class FavoritesBuilder {
    static func make() -> FavoritesViewController {
        let viewController = FavoritesViewController()
        viewController.viewModel = FavoritesViewModel()
        return viewController
    }
}
