//
//  ItemInfoTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

class ItemInfoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var todoTextView: UITextView! {
		didSet {
			self.todoTextView.layer.borderWidth = 1
			self.todoTextView.layer.borderColor = UIColor.systemGray4.cgColor
			self.todoTextView.layer.cornerRadius = 8
			self.todoTextView.layer.masksToBounds = true
			self.todoTextView.inputAccessoryView = DoneToolbar(activeControl: self.todoTextView)
		}
	}

	func configure(with model: ItemInfoCellViewModel) {
		self.todoTextView.delegate = model
	}
}
