//
//  AppContainer.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 13.09.2024.
//

import Foundation
import StatsAPI


let app = AppContainer()

final class AppContainer {
    let service = AppService()
    let router = AppRouter()
}
