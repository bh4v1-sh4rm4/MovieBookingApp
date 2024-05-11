//
//  AppDelegate.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 04/04/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        setUpRootVC()
        FirebaseApp.configure()
        let isLoogedIn = isUserLoggedIn()
        if isLoogedIn{
            changeRootViewController()
        }else{
            setUpRootVC()
        }
        // Override point for customization after application launch.
        return true
    }
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }
    
    func setUpRootVC() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        window?.makeKeyAndVisible()
    }
    func changeRootViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        window?.rootViewController = UINavigationController(rootViewController: homeViewController)
        window?.makeKeyAndVisible()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "userFile", relativeTo: directoryURL).appendingPathExtension("txt")
        guard let data = try? encoder.encode(savedDetails) else {
            print("Unable to encode saved details")
            return
        }
        do {
            try data.write(to: fileURL)
            print("File saved: \(fileURL.absoluteURL)")
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
    }
}

