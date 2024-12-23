//
//  StatsTrackerCellModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 13.11.2024.
//

import Foundation

protocol STCellViewModelProtocol {
    var delegate: STCellViewModelDelegate? { get set }
    var numberOfRowsInSection: Int { get set }
    func getPlayers()
    func cellForRowAt(index: IndexPath) -> PlayerPresentation
    func didSelectRowAt(index: IndexPath)
}

enum STCellViewModelOutput{
    case showPlayers
}

enum STCellRoute {
    case playerPage(Int)
}

protocol STCellViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: STCellViewModelOutput)
    func navigate(to route: STCellRoute)
}
