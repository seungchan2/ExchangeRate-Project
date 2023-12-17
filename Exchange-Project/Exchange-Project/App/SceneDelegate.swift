//
//  SceneDelegate.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController(rootViewController: ExchangeRateViewController(viewModel: ExchangeViewModel(networkProvider: ExchangeRateService())))
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
