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
	func removeToDoFromDB(id: String)
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
	
	func removeToDoFromDB(id: String) {
		if let currentToDoItem = mainRealm.object(ofType: ToDoItemEntity.self, forPrimaryKey: id) {
			realmWrite {
				mainRealm.delete(currentToDoItem)
			}
		}
	}
	
	
	func getToDoItems() -> [ToDoItemEntity] {
		var todoItems = [ToDoItemEntity]()
		let sortedToDoItems = Array(self.savedToDoItems).sorted { (savedItem1, savedItem2) -> Bool in
			return savedItem1.stringDate < savedItem2.stringDate
		}
		for toDoItem in sortedToDoItems {
			todoItems.append(toDoItem)
		}
		return todoItems
	}
}
