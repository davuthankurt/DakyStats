//
//  LeagueViewModel.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 14.09.2024.
//

import Foundation
import StatsAPI

final class LeagueViewModel: LeaguesViewModelProtocol {
    weak var delegate: LeaguesViewModelDelegate?
    private let service: AppService
    public var leagues: [LeagueResponse?]
    var leagueCell: [LeaguePresentation?]
    var leagueResults: [Int: LeagueResponse] = [:]
    let leagueIds = [39,140,135,78,61,203]
    
    init(service: AppService) {
        self.service = service
        leagues = Array(repeating: nil, count: leagueIds.count)
        leagueCell = Array(repeating: nil, count: leagueIds.count)
    }
}

extension LeagueViewModel {
    
    func loadTopScorers() async {
        notify(.updateTitle("DAKY Stats"))
        
        await withTaskGroup(of: (Int, LeagueResponse?).self) { group in
            for (index, league) in leagueIds.enumerated() {
                group.addTask {
                    do {
                        let response = try await self.service.fetchData2(from: .standings(league: league), responseType: LeagueResponse.self)
                        return (index, response)
                    } catch {
                        print(error.localizedDescription)
                        return (index, nil)
                    }
                }
            }
            
            for await (index, leagueResponse) in group {
                guard let leagueResponse = leagueResponse else { return }
                leagues[index] = leagueResponse
                let leaguePresentation = leagueResponse.results.map { LeaguePresentation(league: $0) }
                guard let presentation = leaguePresentation.first else { return }
                leagueCell[index] = presentation
            }
        }
        
        if leagueCell.allSatisfy({ $0 != nil }) {
            notify(.showLeagues)
        }
    }
    
    func didSelectRowAt(index: IndexPath) {
        guard let league = leagues[index.item] else { return }
        if let selectedLeague = league.results.first {
            let viewModel = StandingsViewModel(league: selectedLeague, leagueName: selectedLeague.name)
            delegate?.navigate(to: .standings(viewModel))
        } else {
            print("no league available")
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return leagues.count
    }
    
    func cellForItemAt(index: IndexPath) -> LeaguePresentation? {
        guard leagues[index.item] != nil else { return nil }
        return leagueCell[index.item]
    }
    
    private func notify(_ output: LeaguesViewModelOutput){
        delegate?.handleViewModelOutput(output)
    }
}
