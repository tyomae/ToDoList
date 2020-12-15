//
//  Realm+Notifications.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 15.12.2020.
//

import Foundation

extension Notification.Name {
	static let RealmLoadingErrorNotifications: Notification.Name =
		Notification.Name(rawValue: "RealmLoadingErrorNotifications")
	static let RealmWritingErrorNotifications: Notification.Name =
		Notification.Name(rawValue: "RealmWritingErrorNotifications")
}
