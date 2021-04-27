//
//  AppDelegate.swift
//  FinKick
//
//  Created by 김진우 on 2021/01/01.
//

import UIKit
import CoreData

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var success: Int = 0
    var ID : String!
    var Pass : String!
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Users") // 여기는 파일명을 적어줘요.
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error {
                    fatalError("Unresolved error, \((error as NSError).userInfo)")
                }
            })
            return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.27, green: 0.29, blue: 0.35, alpha: 1.00)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

