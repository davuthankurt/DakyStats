//
//  StatsTrackerCellViewModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 13.11.2024.
//

import Foundation


final class StatsTrackerCellViewModel: STCellViewModelProtocol {
    
    var delegate: STCellViewModelDelegate?
    var numberOfRowsInSection: Int
    
    var topStats: [PlayerPresentation]
    var goalOrAssist: Bool
    
    init(topStats: [PlayerPresentation], goalOrAssist: Bool) {
        self.topStats = topStats
        self.goalOrAssist = goalOrAssist
        self.numberOfRowsInSection = topStats.count
    }
}

extension StatsTrackerCellViewModel {
    
    func getPlayers() {
        notify(.showPlayers)
    }
    
    func cellForRowAt(index: IndexPath) -> PlayerPresentation {
        return topStats[index.row]
    }
    
    func didSelectRowAt(index: IndexPath) {
        let player = topStats[index.row].player.id
        
        delegate?.navigate(to: .playerPage(player))
    }
    
    func notify(_ output: STCellViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

