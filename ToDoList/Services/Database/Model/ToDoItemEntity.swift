//
//  ToDoItemEntity.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 15.12.2020.
//

import Foundation
import RealmSwift

class ToDoItemEntity: Object {
	@objc dynamic var id: String = UUID().uuidString
	@objc dynamic var date = Date()
	@objc dynamic var itemTitle: String = ""
	@objc dynamic var itemNote: String = ""

	convenience init(date: Date, itemTitle: String, itemNote: String) {
		self.init()
		self.date = date
		self.itemTitle = itemTitle
		self.itemNote = itemNote
	}
	
	override class func primaryKey() -> String? {
		"id"
	}
}