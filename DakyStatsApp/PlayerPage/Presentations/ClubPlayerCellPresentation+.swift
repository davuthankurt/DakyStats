//
//  ClubPlayerCellPresentation+.swift
//  StatsApp
//
//  Created by Davuthan Kurt on 23.10.2024.
//

import Foundation
import StatsAPI

extension ClubPlayerCellPresentation {
    convenience init(cell: Players) {
        self.init(id: cell.id, name: cell.name, age: cell.age, number: cell.number, position: cell.position, photo: cell.photo)
    }
}
