//
//  StandingsContracts.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 27.09.2024.
//

import Foundation

protocol StandingsViewModelProtocol {
    var delegate: StandingsViewModelDelegate? { get set }
    func didSelectRowAt(index: IndexPath)
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(index: IndexPath) -> StandingsCellPresentation
    func loadStandings()
}

enum StandingsViewModelOutput {
    case updateTitle(String)
    case showTeams
}

enum StandingsViewRoute {
    case clubPage(Int)
}

protocol StandingsViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: StandingsViewModelOutput)
    func navigate(to route: StandingsViewRoute)
}
