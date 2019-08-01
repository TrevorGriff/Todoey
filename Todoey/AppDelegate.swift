//
//  AppDelegate.swift
//  Todoey
//
//  Created by Trevor Griffiths on 7/1/19.
//  Copyright © 2019 Trevor Griffiths. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
           _ = try Realm()
           
        }catch{
            print("Error initialising new Realm")
        }
        
        return true
    }

}

