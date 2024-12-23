//
//  StandingsViewModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 27.09.2024.
//

import Foundation
import StatsAPI

final class StandingsViewModel: StandingsViewModelProtocol {

    weak var delegate: StandingsViewModelDelegate?
    public var standings: StandingsPresentation
    public var leagueName: String
    var standingCells: [StandingsCellPresentation] = []
    
    init(league: League, leagueName: String) {
        self.standings = StandingsPresentation(league: league)
        self.leagueName = leagueName
    }
}

extension StandingsViewModel {
    
    func loadStandings() {
        guard let temp = standings.standings.first else { return }
        standingCells.append(contentsOf: temp.map { StandingsCellPresentation(team: $0) })
        notify(.updateTitle(leagueName))
        notify(.showTeams)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let teams = standings.standings.first else { return 0 }
        return teams.count
    }
    
    func cellForRowAt(index: IndexPath) -> StandingsCellPresentation {
        return standingCells[index.row]
    }
    
    func didSelectRowAt(index: IndexPath) {
        guard let team = standings.standings.first?[index.row].team.id else { return }
        delegate?.navigate(to: .clubPage(team))
    }
    
    private func notify(_ output: StandingsViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
}


