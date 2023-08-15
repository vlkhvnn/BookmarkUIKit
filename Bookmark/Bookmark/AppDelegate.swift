//
//  AppDelegate.swift
//  Bookmark
//
//  Created by Alikhan Tangirbergen on 14.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let onboardingCompleted = UserDefaults.standard.bool(forKey: "onboardingCompleted")
        if !onboardingCompleted {
            window?.rootViewController = UINavigationController(rootViewController: OnboardingScreen())
        }
        else {
            window?.rootViewController = UINavigationController(rootViewController: MainScreen())
        }
        window?.makeKeyAndVisible()
        return true
    }
}


