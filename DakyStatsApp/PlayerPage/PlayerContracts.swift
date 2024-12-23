//
//  PlayerContracts.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import Foundation
import StatsAPI

protocol PlayerViewModelProtocol {
    var delegete: PlayerViewModelDelegate? { get set }
    var playerProfile: [(title: String, value: String)] { get }
    var playerStat: [(title: String, value: String)] { get }
    func setProfileData()
    func loadPlayer()
    func numberOfRowsInComponent() -> Int 
    func titleForRow(row: Int) -> String
    func setPlayerImage() -> String
    func setPlayerName() -> String
    func cellForItemAt(index: IndexPath) -> PlayerOrStatistics
    func setRightBarButtonImage(completion: @escaping (String) -> Void)
    func addRemoveFavorite(completion: @escaping (String) -> Void)
}

enum PlayerOrStatistics {
    case player(data: Player)
    case stats(data: Statistics)
}

enum PlayerViewModelOutput {
    case showPlayerPage
    case updateTitle(String)
}

protocol PlayerViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: PlayerViewModelOutput)
}
