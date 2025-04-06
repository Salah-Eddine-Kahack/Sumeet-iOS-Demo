//
//  SceneDelegate.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    var rootCoordinator: RootCoordinator!
    
    // MARK: - Methods

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator.start()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
