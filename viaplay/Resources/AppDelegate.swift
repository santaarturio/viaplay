//
//  AppDelegate.swift
//  viaplay
//
//  Created by Artur Nikolaienko on 10.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool { true }
  
  func applicationWillResignActive(_ application: UIApplication) {
    DataBaseManager.viaplay.save()
  }
}
