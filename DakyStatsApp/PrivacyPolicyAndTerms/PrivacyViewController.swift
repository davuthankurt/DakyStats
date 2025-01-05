//
//  PolicyViewController.swift
//  DakyStatsApp
//
//  Created by Davuthan Kurt on 1.01.2025.
//

import UIKit

class PolicyViewController: UIViewController {
    var viewModel: PrivacyViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
}

extension PolicyViewController: PolicyViewModelDelegate {
    
}
