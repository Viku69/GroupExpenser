//
//  LoginAuthApp.swift
//  LoginAuth
//
//  Created by Vikram Singh on 04/10/23.
//

import SwiftUI
import Firebase

@main
struct LoginAuthApp: App {
    @StateObject private var groupsViewModel = GroupsViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(groupsViewModel)
        }
    }
}

// Initialize firebase

class AppDelegate : NSObject , UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    // Phone auth needs to be Initilaize remote notifications
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}
