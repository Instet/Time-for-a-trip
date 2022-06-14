//
//  AppDelegate.swift
//  Time for a trip
//
//  Created by Руслан Магомедов on 10.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let flightVC = TicketsViewController()
        let flightNC = UINavigationController(rootViewController: flightVC)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black ] 

        flightNC.navigationBar.standardAppearance = appearance
        flightNC.navigationBar.scrollEdgeAppearance = flightNC.navigationBar.standardAppearance

        flightNC.navigationBar.topItem?.title = "Air tickets"




        window?.rootViewController = flightNC
        window?.makeKeyAndVisible()
        return true
    }

}

