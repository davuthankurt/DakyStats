//
//  AppRouter.swift
//  FootballApp
//
//  Created by Davuthan Kurt on 13.09.2024.
//

import UIKit
import FirebaseAuth

final class AppRouter {
    func start(window: UIWindow){
        let tabBarController = createTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        configureTabBarAppearance(for: tabBarController.tabBar)
        
        let leagueNavigationController = createNavigationController(
            rootViewController: LeaguesBuilder.make(),
            title: "Leagues",
            image: UIImage(systemName: "list.dash")
        )
        
        let statsTrackerNavigationController = createNavigationController(
            rootViewController: StatsTrackerBuilder.make(),
            title: "Stats Tracker",
            image: UIImage(systemName: "figure.soccer")
        )
        
        let favoritesNavigationController = createNavigationController(
            rootViewController: FavoritesBuilder.make(),
            title: "Favorites",
            image: UIImage(systemName: "star")
        )
        
        tabBarController.viewControllers = [
            leagueNavigationController,
            statsTrackerNavigationController,
            favoritesNavigationController
        ]
        
        return tabBarController
    }
    
    private func configureTabBarAppearance(for tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 182/255, green: 191/255, blue: 185/255, alpha: 1)
    }
    
    private func createNavigationController( rootViewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        
        configureNavigationBarAppearance(for: navigationController.navigationBar)
        return navigationController
    }
    
    private func configureNavigationBarAppearance(for navigationBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = UIColor(red: 36/255, green: 54/255, blue: 66/255, alpha: 1)
    }
    
    func configureStatusBar(windowScene: UIWindowScene) -> UIView{
        let statusBarFrame = windowScene.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = UIColor(red: 226/255, green: 241/255, blue: 231/255, alpha: 1)
        return statusBarView
    }
    
    func signInAnonymously(completion: @escaping (Bool) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Error signing in anonymously: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let user = authResult?.user else {
                print("Failed to retrieve user.")
                completion(false)
                return
            }
            print("Signed in as user with UID: \(user.uid)")
            completion(true)
        }
    }
}

