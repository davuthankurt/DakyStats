//
//  ClubPlayerCellPresentation.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 23.10.2024.
//

import Foundation

final class ClubPlayerCellPresentation: NSObject {
    let id: Int
    let name: String?
    let age: Int?
    let number: Int?
    let position: String?
    let photo: String?
    
    init(id: Int, name: String?, age: Int?, number: Int?, position: String?, photo: String?) {
        self.id = id
        self.name = name
        self.age = age
        self.number = number
        self.position = position
        self.photo = photo
    }
}
