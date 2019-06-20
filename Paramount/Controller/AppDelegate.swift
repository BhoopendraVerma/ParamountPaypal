//
//  AppDelegate.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 27/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var formCurrencyStr = String()
    var toCurrencyStr = String()
    var amountCurrency = Double()
    var deviceID = String()
    var tokenPaypal = String()
    var userCardDetaisl = NSDictionary()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AfhVxBUKOnf1E1DeT4o7-CQA0rfUco2NLLG0OAYXGdSRuf8gjbxzH7P77bTevnzY_1I60N6MXYYeLQqO", PayPalEnvironmentSandbox: "AW-KNtfMzKaTEB7BJSzSUeJwiMdO2A6tOErRp88nztu_Ezg3Yt--jjg0XJRjc2C3FG-nP_OgEpHjTH0r"])
//AdlCgGGFrYPjUVRufjberInKmwH75hJCbDIuMm6gKuprfdzAbIch7jil0AZs4Z1kvcJP8t_Th45Ncdbb

       // Manjit Client ID //AfhVxBUKOnf1E1DeT4o7-CQA0rfUco2NLLG0OAYXGdSRuf8gjbxzH7P77bTevnzY_1I60N6MXYYeLQqO
        
       // Ashish sir Client ID //AYqh0mzbmclzlOONL2nrNsx1Yu5h_wue7w6cejJnAkQSf5qClaTBKm8Ta_6UjZJOGYAsgglQAKQnwnW-

        let user = UserDefaults.standard
        if let userLog = user.value(forKey: "checkLogin")
        {
            var str  = String()
            str = userLog as! String
            if str == "UserLogin"
            {
                DispatchQueue.main.async {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
                    let rootViewController = self.window!.rootViewController as! UINavigationController
                    rootViewController.pushViewController(loginPageView, animated: false)
                }
            }
            else
            {
                DispatchQueue.main.async {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    let rootViewController = self.window!.rootViewController as! UINavigationController
                    rootViewController.pushViewController(loginPageView, animated: false)
                }
            }
        }
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("\(token)")
        deviceID = token
    }
    
     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any])
     {
        userCardDetaisl = userInfo as NSDictionary
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: (userCardDetaisl as! [AnyHashable : Any]))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: (userCardDetaisl as! Dictionary))

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("i am not available in simulator \(error)")
        deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Paramount")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
