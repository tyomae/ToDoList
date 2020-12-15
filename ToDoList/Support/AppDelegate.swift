//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 11.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		RealmController.shared.setup()
		return true
	}
}

