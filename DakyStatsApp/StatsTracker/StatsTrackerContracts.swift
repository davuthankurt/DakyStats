//
//  StatsTrackerContracts.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 29.10.2024.
//

import Foundation


protocol StatsTrackerViewModelProtocol {
    var delegate: StatsTrackerViewModelDelegate? { get set }
    var leaguesGoalScorers: [[PlayerPresentation]] { get }
    var leaguesAssisters: [[PlayerPresentation]] { get }
    func loadTopScorers() async
    func loadTopAsisters() async
    func showSwipeAlert() -> Bool
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(index: IndexPath) -> String
    func viewForSupplementaryElementOfKind(index: IndexPath) -> String
    func injectCellViewModel(index: IndexPath) -> StatsTrackerCellViewModel
}

enum StatsTrackerViewModelOutput {
    case showTopScorers
    case showTopAssisters
    case updateTitle(String)
}

protocol StatsTrackerViewModelDelegate {
    func handleViewModelOutput(_ output: StatsTrackerViewModelOutput)
}
