//
//  ItemInfoTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

class ItemInfoTableViewCell: UITableViewCell {

	@IBOutlet weak var toDoTextField: UITextField!
	
	func configure(with model: ItemInfoCellViewModel) {
		self.toDoTextField.delegate = model
	}
}
