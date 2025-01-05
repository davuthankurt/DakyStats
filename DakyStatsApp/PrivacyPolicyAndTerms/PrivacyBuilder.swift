//
//  PrivacyBuilder.swift
//  DakyStatsApp
//
//  Created by Davuthan Kurt on 1.01.2025.
//

import Foundation

final class PrivacyBuilder {
    static func make() -> PrivacyViewController {
        let vc = PrivacyViewController()
        vc.viewModel = PrivacyViewModel()
        return vc
    }
}
