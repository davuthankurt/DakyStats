//
//  StatsTrackerViewModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 29.10.2024.
//

import Foundation
import StatsAPI

final class StatsTrackerViewModel: StatsTrackerViewModelProtocol {
    
    private let service: AppService
    var delegate: StatsTrackerViewModelDelegate?
    
    //        39 pl, 203 superlig, 135 serie a, 61 ligue 1, 78 bundesliga, 140 la liga, 2 cl
    // 2,140,135,78,61,203
    let leagueIds = [39]
    let userDefaults = UserDefaults.standard
    
    public var leaguesGoalScorers: [[PlayerPresentation]]
    public var leaguesAssisters: [[PlayerPresentation]]
    
    init(service: AppService) {
        self.service = service
        self.leaguesGoalScorers = Array(repeating: [], count: leagueIds.count)
        self.leaguesAssisters = Array(repeating: [], count: leagueIds.count)
    }
}

extension StatsTrackerViewModel {
    
    func loadTopScorers() async {
        notify(.updateTitle("DAKY Stats"))
        
        await withTaskGroup(of: (Int, [PlayerPresentation]).self) { group in
            for (index, league) in leagueIds.enumerated() {
                group.addTask {
                    do {
                        let response = try await self.service.fetchData2(from: .topScorers(id: league), responseType: PlayerResponse.self)
                        let footballers = Array(response.response.prefix(5))
                        let leaguePresentation = footballers.map { PlayerPresentation(footballer: $0) }
                        return (index, leaguePresentation)
                    } catch {
                        print(error.localizedDescription)
                        return (index, [])
                    }
                }
            }
            
            for await (index, leaguePresentation) in group {
                leaguesGoalScorers[index] = leaguePresentation
            }
        }
        
        if let lastLeague = leaguesGoalScorers.last, !lastLeague.isEmpty {
            notify(.showTopScorers)
        }
    }
    
    func loadTopAsisters() async {
        await withTaskGroup(of: (Int, [PlayerPresentation]).self) { group in
            for (index, league) in leagueIds.enumerated() {
                group.addTask {
                    do {
                        let response = try await self.service.fetchData2(from: .topAsisters(id: league), responseType: PlayerResponse.self)
                        let footballers = Array(response.response.prefix(5))
                        let leaguePresentation = footballers.map { PlayerPresentation(footballer: $0) }
                        return (index, leaguePresentation)
                    } catch {
                        print(error.localizedDescription)
                        return (index, [])
                    }
                }
            }
            
            for await (index, leaguePresentation) in group {
                leaguesAssisters[index] = leaguePresentation
            }
        }
        
        if let lastLeague = leaguesAssisters.last, !lastLeague.isEmpty {
            notify(.showTopAssisters)
        }
    }
    
    func showSwipeAlert() -> Bool {
        
        if !userDefaults.bool(forKey: "AlertShowed") {
            userDefaults.set(true, forKey: "AlertShowed")
            return true
        }
        return false
    }
    
    func numberOfSections() -> Int {
        return leaguesGoalScorers.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if !leaguesGoalScorers.isEmpty && !leaguesAssisters.isEmpty {
            return 2
        }
        return 0
    }
    
    func cellForItemAt(index: IndexPath) -> String {
        if index.item == 0 {
            return "Top Scorers"
        } else {
            return "Top Assisters"
        }
    }
    
    func injectCellViewModel(index: IndexPath) -> StatsTrackerCellViewModel {
        if index.item == 0 {
            return StatsTrackerCellViewModel(topStats: leaguesGoalScorers[index.section], goalOrAssist: true)
        } else {
             return StatsTrackerCellViewModel(topStats: leaguesAssisters[index.section], goalOrAssist: false)
        }
    }
    
    func viewForSupplementaryElementOfKind (index: IndexPath) -> String {
        let leagueScorers = leaguesGoalScorers[index.section]
        guard let player = leagueScorers.first, let playerStats = player.statistics.first, let leagueName = playerStats.league.name else { return "" }
        return leagueName
    }
    
    func notify(_ output: StatsTrackerViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
