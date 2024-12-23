//
//  ClubsContracts.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 11.10.2024.
//

import Foundation
import StatsAPI

protocol ClubsViewModelProtocol {
    var delegate: ClubsViewModelDelegate? { get set }
    func didSelectRowAt(index: IndexPath)
    func cellForRowAt(index: IndexPath) -> ClubPlayerCellPresentation
    func numberOfRowsInSection(section: Int) -> Int
    func loadClub()
    func setClubImage() -> String
    func setClubName() -> String
}

enum ClubsViewModelOutput {
    case updateTitle(String)
    case showClubPage
}

enum ClubsViewRoute {
    case playerPage(Int)
}
protocol ClubsViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ClubsViewModelOutput)
    func navigate(to route: ClubsViewRoute)
}
