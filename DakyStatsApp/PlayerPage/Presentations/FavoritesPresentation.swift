//
//  FavoritesPresentation.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 14.12.2024.
//

import Foundation

final class FavoritesPresentation: NSObject {
    let id: Int?
    let photo: String?
    let name: String?
    
    init(id: Int?, photo: String?, name: String?) {
        self.id = id
        self.photo = photo
        self.name = name
    }
}
