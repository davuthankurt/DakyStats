//
//  PrivacyContracts.swift
//  DakyStatsApp
//
//  Created by Davuthan Kurt on 1.01.2025.
//

import Foundation

protocol PrivacyViewModelProtocol {
    var delegate: PrivacyViewModelDelegate? { get set }
    func openPrivacy()
    func openTerms()
    func launchApp()
}

protocol PrivacyViewModelDelegate: AnyObject {
    func showSafari(url: URL)
    func navigateToMainScreen()
}
