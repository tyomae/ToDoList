//
//  ListItemTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

class ListItemTableViewCell: UITableViewCell, ConfigurableView {

	@IBOutlet weak var toDoItemLabel: UILabel!
	
	func configure(with model: ListItemCellViewModel) {
		
	}
}
