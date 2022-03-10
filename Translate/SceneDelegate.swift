//
//  SceneDelegate.swift
//  Translate
//
//  Created by Terry on 2022/03/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TabBarController()
        window?.tintColor = UIColor.mainTintColor
        window?.makeKeyAndVisible()
    }
}

