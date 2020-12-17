//
//  ListItemTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

class ListItemTableViewCell: UITableViewCell, ConfigurableView {

	@IBOutlet weak var toDoTitleLabel: UILabel!
	@IBOutlet weak var toDoNoteLabel: UILabel!
	
	func configure(with model: ListItemCellViewModel) {
		self.toDoTitleLabel.text = model.itemTitle
		self.toDoNoteLabel.text = model.itemNote
		if model.isDone {
			self.accessoryType = .checkmark
		} else {
			self.accessoryType = .none
		}
	}
}
