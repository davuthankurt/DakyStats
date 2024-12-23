//
//  FavoritesContracts.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 6.12.2024.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate? { get set }
    func fetchFavorites()
    func updateTitle()
    var numberOfRowsInSection: Int? { get }
    func cellForRowAt(index: IndexPath) -> FavoritesPresentation
    func didSelectRowAt(index: IndexPath)
}

enum FavoritesViewModelOutput {
    case showFavorites
    case updateTitle(String)
}

enum FavoritesRoute {
    case playerPage(Int)
}

protocol FavoritesViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: FavoritesViewModelOutput)
    func navigate(to route: FavoritesRoute)
}
