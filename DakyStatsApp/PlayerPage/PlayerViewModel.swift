//
//  PlayerViewModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 26.10.2024.
//

import Foundation
import StatsAPI
import Firebase
import FirebaseAuth

final class PlayerViewModel: PlayerViewModelProtocol {
    
    
    weak var delegete: PlayerViewModelDelegate?
    private let service: AppService
    let playerId: Int
    var presentation: PlayerPresentation?
    var playerProfile: [(title: String, value: String)] = []
    var playerStat: [(title: String, value: String)] = []
    let userID = Auth.auth().currentUser?.uid
    
    init(service: AppService, playerId: Int) {
        self.service = service
        self.playerId = playerId
    }
}

extension PlayerViewModel {
    
    func loadPlayer() {
        notify(.updateTitle("DAKY Stats"))
        service.fetchData(from: .player(id: playerId), responseType: PlayerResponse.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                guard let footballer = response.response.first else { return }
                presentation = PlayerPresentation(footballer: footballer)
//                playerProfile = presentation?.player
                setProfileData()
                notify(.showPlayerPage)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfileData() {
        let height = presentation?.player.height ?? "-"
        let weight = presentation?.player.weight ?? "-"
        let nationality = presentation?.player.nationality ?? "-"
        let age = presentation?.player.age.map{String($0)} ?? "-"
        playerProfile = [
            ("Age:", age),
            ("Height:", height),
            ("Weight:", weight),
            ("Nationality:", nationality)
        ]
    }

    func numberOfItemsInSection(section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 8
        }
    }
    
    func cellForItemAt(index: IndexPath) -> PlayerOrStatistics {
         
        if index.item == 0 {
            return .player(data: presentation!.player)
        } else {
            return .stats(data: presentation!.statistics[index.item-1])
        }
    }
    
    func numberOfRowsInComponent() -> Int {
        guard let presentation = presentation else { return 0 }
        return 1 + presentation.statistics.count
    }
    
    func titleForRow(row: Int) -> String {
        guard let presentation = presentation else { return "" }
        if row == 0 {
            return "Profile"
        } else {
            guard let name = presentation.statistics[row-1].league.name else { return ""}
            setStatData(row: row)
            return name
        }
    }
    
    func setStatData(row: Int){
        guard let presentation = presentation else { return }
        let appearances = presentation.statistics[row-1].games.appearences.map { String($0) } ?? "-"
        let lineups = presentation.statistics[row-1].games.lineups.map { String($0) } ?? "-"
        let minutes = presentation.statistics[row-1].games.minutes.map { String($0) } ?? "-"
        var rating = presentation.statistics[row-1].games.rating ?? "-"
        let totalGoals = presentation.statistics[row-1].goals.total.map { String($0) } ?? "-"
        let assists = presentation.statistics[row-1].goals.assists.map { String($0) } ?? "-"
        let yellowCards = presentation.statistics[row-1].cards.yellow.map { String($0) } ?? "-"
        let redCards = presentation.statistics[row-1].cards.red.map { String($0) } ?? "-"
        rating = String(rating.prefix(4))
        
        playerStat = [
            ("Appearances:", appearances),
            ("Lineups:", lineups),
            ("Minutes:", minutes),
            ("Rating:", rating),
            ("Goals:", totalGoals),
            ("Assists:", assists),
            ("Yellow Cards:", yellowCards),
            ("Red Cards:",redCards)
        ]
    }
    
    func getSegmentTitles() -> [String] {
        guard let presentation = presentation else { return ["-"] }
        var leagueNames = [String]()
        for i in 0..<presentation.statistics.count{
            if let leagueName = presentation.statistics[i].league.name {
                leagueNames.append(leagueName)
            }
        }
        return ["Profile"] + leagueNames
    }
    
    func setPlayerImage() -> String {
        guard let playerPresentation = presentation, let playerPhoto = playerPresentation.player.photo else { return "-" }
        return playerPhoto
    }
    
    func setPlayerName() ->String {
        guard let playerPresentation = presentation, 
              let playerFirstName = playerPresentation.player.firstname,
              let playerLastname = playerPresentation.player.lastname else { 
            guard let playerPresentation = presentation,
                  let playerName = playerPresentation.player.name else { return "-" }
            return playerName }
        return playerFirstName + " " + playerLastname
    }
    
    func setRightBarButtonImage(completion: @escaping (String) -> Void) {
        guard let userID = userID else {
            completion("")
            return
        }
        let ref = Database.database().reference()
        ref.child(userID).child("\(playerId)").observeSingleEvent(of: .value) { [weak self] snapshot in
            if snapshot.exists() {
                completion("star.fill")
            } else {
                completion("star")
            }
        }
    }
    
    func addRemoveFavorite(completion: @escaping (String) -> Void) {
        guard let userID = userID else {
            completion("")
            return
        }
        
        let ref = Database.database().reference()
        ref.child(userID).child("\(playerId)").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self else { return }
            if snapshot.exists() {
                ref.child(userID).child("\(playerId)").removeValue()
                completion("star")
            } else {
                ref.child(userID).child("\(playerId)").setValue([
                    "name": presentation?.player.name,
                    "photo": presentation?.player.photo])
                completion("star.fill")
            }
        }
    }
    
    func notify(_ output: PlayerViewModelOutput) {
        delegete?.handleViewModelOutput(output)
    }
}
