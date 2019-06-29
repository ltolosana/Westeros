//
//  AppDelegate.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 11/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var houseListNavigation: UINavigationController?
    var houseDetailNavigation: UINavigationController?
    
    var seasonListNavigation: UINavigationController?
    var episodeListNavigation: UINavigationController?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //  Lanzar la app
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Crear los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        
        // Creamos los controladores // Lo metemos directamente en el combinador
//        var controllers = [UINavigationController]()
//        for house in houses {
//            controllers.append(HouseDetailViewController(model: house).wrappedInNavigation())
//        }

        
//        // Creamos el combinador
//        let tabBarController = UITabBarController()
//        // tabBarController.viewControllers = controllers
//        tabBarController.viewControllers = houses
//            .map { HouseDetailViewController(model: $0).wrappedInNavigation() }
        
        // Creamos los controladores
        let houseListViewController = HouseListViewController(model: houses)
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        
//        let seasonDetailViewController = SeasonDetailViewController(model: seasons[0])
        let episodeListViewController = EpisodeListViewController(model: seasons[0].sortedEpisodes, seasonName: seasons[0].name)
        
        // Asignamos delegados
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = episodeListViewController
        
        
        // Los envolvemos en Navigations
        houseListNavigation = houseListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
//        let seassonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        episodeListNavigation = episodeListViewController.wrappedInNavigation()
        
        
        // Creo el combinador TabBar con el houseList y el seasonList
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [houseListNavigation!, seasonListNavigation!]
        tabbarController.delegate = self
        
        // Creamos el split view controller
        let splitViewController = UISplitViewController()
//        splitViewController.viewControllers = [houseListNavigation, houseDetailNavigation] // El primero que metes en el array es el Master y el segundo es el Detail
//        splitViewController.viewControllers = [seasonListNavigation, episodeListNavigation] // El primero que metes en el array es el Master y el segundo es el Detail
        splitViewController.viewControllers = [tabbarController, houseDetailNavigation!] // El primero que metes en el array es el Master y el segundo es el Detail
        
        //Asignamos el rootViewController
//        window?.rootViewController = splitViewController
        window?.rootViewController = splitViewController
        
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

extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case houseListNavigation:
            tabBarController.splitViewController?.viewControllers[1] = houseDetailNavigation!
        case seasonListNavigation:
            tabBarController.splitViewController?.viewControllers[1] = episodeListNavigation!
        default:
            print("defecto")
        }
    }
}

