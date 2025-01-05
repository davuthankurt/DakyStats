//
//  PolicyViewModel.swift
//  DakyStatsApp
//
//  Created by Davuthan Kurt on 1.01.2025.
//

import Foundation

final class PrivacyViewModel: PrivacyViewModelProtocol {
    var delegate: PrivacyViewModelDelegate?
    let userDefaults = UserDefaults.standard
    let privacyURL = "https://sites.google.com/view/dakystats-privacypolicy/ana-sayfa"
    let termsURL =  "https://sites.google.com/view/dakystats-termsandconditions/ana-sayfa"
    
}

extension PrivacyViewModel {
    func launchApp(){
        userDefaults.set(true, forKey: "hasAcceptedTermsAndPrivacy")
        delegate?.navigateToMainScreen()
    }
    
    func openPrivacy(){
        guard let url = URL(string: privacyURL) else { return }
        delegate?.showSafari(url: url)
    }
    
    func openTerms() {
        guard let url = URL(string: termsURL) else { return }
        delegate?.showSafari(url: url)
    }
}
