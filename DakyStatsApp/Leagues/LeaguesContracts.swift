//
//  LeaguesContracts.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 13.09.2024.
//

import Foundation


protocol LeaguesViewModelProtocol {
    var delegate: LeaguesViewModelDelegate? { get set }
    func loadTopScorers() async
    func didSelectRowAt(index: IndexPath)
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(index: IndexPath) -> LeaguePresentation?
}

enum LeaguesViewModelOutput {
    case updateTitle(String)
    case showLeagues
}

enum LeaguesViewRoute{
    case standings(StandingsViewModelProtocol)
}

protocol LeaguesViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: LeaguesViewModelOutput)
    func navigate(to route: LeaguesViewRoute)
}
