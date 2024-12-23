//
//  FavoritesViewModel.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 6.12.2024.
//

import Foundation
import Firebase
import FirebaseAuth

final class FavoritesViewModel: FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate?
    var favoritesList = [FavoritesPresentation]()
    var numberOfRowsInSection: Int?
}

extension FavoritesViewModel {
    
    func updateTitle(){
        notify(.updateTitle("DAKY Stats"))
    }

    func fetchFavorites() {
        favoritesList.removeAll()
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference()
        ref.child(userId).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self else { return }
            for child in snapshot.children {
                if let snapshotChild = child as? DataSnapshot,
                   let value = snapshotChild.value as? [String: Any],
                   let name = value["name"] as? String,
                   let photo = value["photo"] as? String,
                   let id = Int(snapshotChild.key) {
                    let favoritePlayer = FavoritesPresentation(id: id, photo: photo, name:  name)
                    favoritesList.append(favoritePlayer)
                }
            }
            numberOfRowsInSection = favoritesList.count
            notify(.showFavorites)
        }
    }
    
    func cellForRowAt(index: IndexPath) -> FavoritesPresentation {
        return favoritesList[index.row]
    }
    
    func didSelectRowAt(index: IndexPath) {
        guard let player = favoritesList[index.row].id else { return }
        
        delegate?.navigate(to: .playerPage(player))
    }
    
    func notify(_ output: FavoritesViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
