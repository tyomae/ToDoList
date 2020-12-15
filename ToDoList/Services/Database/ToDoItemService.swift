//
//  ToDoItemService.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 15.12.2020.
//

import UIKit
import RealmSwift

protocol ToDoItemService {
	func addItemToDB(toDoItem: ToDoItemEntity)
	func addListener(handler: @escaping (() -> Void))
	func getToDoItems() -> [ToDoItemEntity]
}

class ToDoItemServiceImpl: ToDoItemService {
	
	private var savedToDoItems = mainRealm.objects(ToDoItemEntity.self)
	private var notificationToken: NotificationToken?
	private var _handler: (() -> ())?
	
	func addListener(handler: @escaping (() -> Void)) {
		self._handler = handler
		self.notificationToken = self.savedToDoItems.observe { [weak self] _ in
			self?._handler?()
		}
	}
	
	deinit {
		self.notificationToken?.invalidate()
	}
	
	func addItemToDB(toDoItem: ToDoItemEntity) {
		let toDoItemEntity = toDoItem
		realmWrite {
			mainRealm.add(toDoItemEntity)
		}
	}
	
	//	func removeFavouriteCountry(countryCode: String) {
	//		if let currentCountryCode = mainRealm.object(ofType: FavouriteCountryEntity.self, forPrimaryKey: countryCode) {
	//			realmWrite {
	//				mainRealm.delete(currentCountryCode)
	//			}
	//		}
	//	}
	//
	func getToDoItems() -> [ToDoItemEntity] {
		var todoItems = [ToDoItemEntity]()
		let sortedToDoItems = Array(self.savedToDoItems).sorted { (savedItem1, savedItem2) -> Bool in
			return savedItem1.date < savedItem2.date
		}
		for toDoItem in sortedToDoItems {
			todoItems.append(toDoItem)
		}
		return todoItems
	}
}
