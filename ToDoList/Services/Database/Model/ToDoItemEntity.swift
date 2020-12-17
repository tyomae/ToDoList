//
//  ToDoItemEntity.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 15.12.2020.
//

import Foundation
import RealmSwift

class ToDoItemEntity: Object {
	@objc dynamic var id: String = ""
	@objc dynamic var date: Date = Date()
	@objc dynamic var itemTitle: String = ""
	@objc dynamic var itemNote: String = ""
	@objc dynamic var isDone: Bool = false

	convenience init(id: String, date: Date, itemTitle: String, itemNote: String, isDone: Bool) {
		self.init()
		self.id = id
		self.date = date
		self.itemTitle = itemTitle
		self.itemNote = itemNote
		self.isDone = isDone
	}
	
	override class func primaryKey() -> String? {
		"id"
	}
}
