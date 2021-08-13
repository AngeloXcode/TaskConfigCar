//
//  AppDelegate.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigatorController = UINavigationController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let productVC = storyboard.instantiateViewController(withIdentifier: startVCName) as? ProductVC else {
            fatalError("Unable to instantiate an ViewController from the storyboard")
        }
        navigatorController.pushViewController(productVC, animated: true)
        self.window?.rootViewController = navigatorController
        window?.makeKeyAndVisible()
        return true
    }

}

