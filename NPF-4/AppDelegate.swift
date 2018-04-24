//
//  AppDelegate.swift
//  NPF-4
//
//  Created by Student on 4/19/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var parks: [Park] = []
    
    var tabBarController: UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
                let tempArray = tempDict["parks"] as! Array<[String:Any]>
                
                for dict in tempArray {
                    let parkName = dict["parkName"]! as! String
                    let parkLocation = dict["parkLocation"]! as! String
                    let parkDescription = dict["description"]! as! String
                    let imageUrl = dict["imageLink"]! as! String
                    let dateFormed = dict["dateFormed"]! as! String
                    let area = dict["area"]! as! String
                    let latitude = Double(dict["latitude"]! as! String)!
                    let longitude = Double(dict["longitude"]! as! String)!
                    let link = dict["link"]! as! String
                    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    let p = Park(coordinate: coordinate, parkName: parkName, parkLocation: parkLocation, parkDescription: parkDescription, imageUrl: imageUrl, dateFormed: dateFormed, area: area, link: link)
                    parks.append(p)
                }
                
                parks.sort(by: {$0.name < $1.name})
            } catch {
                print(error)
            }
        }
        return true
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
    }


}

