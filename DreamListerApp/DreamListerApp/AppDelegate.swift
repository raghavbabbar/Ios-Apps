//
//  AppDelegate.swift
//  DreamListerApp
//
//  Created by raghav babbar on 29/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 let stack = CoreDataStack(modelName:"Model")
    let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true]
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

 

}

