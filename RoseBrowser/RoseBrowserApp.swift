//
//  RoseBrowserApp.swift
//  RoseBrowser
//
//  Created by yangjian on 2023/8/22.
//

import SwiftUI
import UIKit
import FacebookCore

@main
struct RoseBrowserApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Store())
        }
    }
    
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
            ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )
            return true
        }
              
        func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        }
    }
}
