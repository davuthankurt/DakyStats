//
//  ClubsViewModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 11.10.2024.
//

import Foundation
import StatsAPI

final class ClubsViewModel: ClubsViewModelProtocol {
    
    weak var delegate: ClubsViewModelDelegate?
    private let service: AppService
    var playerCell: [ClubPlayerCellPresentation] = []
    var presentation: ClubPresentation?
    let teamId: Int
    init(service: AppService, teamId: Int) {
        self.service = service
        self.teamId = teamId
    }
}

extension ClubsViewModel {
    
    func loadClub() {
        service.fetchData(from: .club(team: teamId), responseType: ClubsResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let clubResponse):
                
                guard let club = clubResponse.results.first else { return }
                presentation = ClubPresentation(club: club)
                guard let presentationClub = presentation else { return }
                playerCell = presentationClub.players.map { ClubPlayerCellPresentation(cell: $0) }
                notify(.updateTitle("DAKY Stats"))
                notify(.showClubPage)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return playerCell.count
    }

    func cellForRowAt(index: IndexPath) -> ClubPlayerCellPresentation  {
        return playerCell[index.row]
    }
        
    func didSelectRowAt(index: IndexPath) {
        let player = playerCell[index.row].id
        
        delegate?.navigate(to: .playerPage(player))
    }
    
    func setClubImage() -> String {
        guard let presentationClub = presentation else { return ""}
        return presentationClub.team.logo
    }
    
    func setClubName() -> String {
        guard let presentationClub = presentation else { return ""}
        return presentationClub.team.name
    }
    
    private func notify(_ output: ClubsViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}

