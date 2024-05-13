//
//  SceneDelegate.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        
        let rootView = UINavigationController(rootViewController: AppViewController())
        window?.rootViewController = rootView
        window?.makeKeyAndVisible()
    }
}

