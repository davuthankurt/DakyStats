//
//  ClubBuilder.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 11.10.2024.
//

import Foundation

final class ClubBuilder {
    
    static func make(id: Int) -> ClubsViewController {
        let viewController = ClubsViewController()
        viewController.viewModel = ClubsViewModel(service: app.service, teamId: id)
        return viewController
    }
}
