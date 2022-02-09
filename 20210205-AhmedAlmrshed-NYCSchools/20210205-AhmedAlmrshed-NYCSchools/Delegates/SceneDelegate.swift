//
//  SceneDelegate.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var cache = SchoolCache()
    var appConfigService = AppConfigurationService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
    }
    
    func makeRootViewController() -> UIViewController {
        let appConfig = appConfigService.loadAppConfiguration()
        /// Check app has the write `iOS version` that the app supports.
        guard appConfig.minimumIOSVersion <= UIDevice.current.systemVersion
            else {
            return BlockingScreenViewController()
        }
        let featureFlagging = FeatureFlagging(appConfiguration: appConfig)
        return MainTabBarController(schoolCache: cache, appConfig: appConfig, featureFlagging: featureFlagging)
    }
}
