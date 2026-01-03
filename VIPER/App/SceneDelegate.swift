//
//  SceneDelegate.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winDowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: winDowScene)
        let testVC = UIViewController()
        testVC.view.backgroundColor = .red
        
        window.rootViewController = testVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

