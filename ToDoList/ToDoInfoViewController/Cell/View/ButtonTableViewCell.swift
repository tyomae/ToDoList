//
//  ButtonTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

class ButtonTableViewCell: UITableViewCell, ConfigurableView {

	@IBOutlet weak var addToDoItemButton: UIButton! {
		didSet {
			self.addToDoItemButton.layer.cornerRadius = 8
			self.addToDoItemButton.layer.masksToBounds = true
		}
	}

	func configure(with model: ButtonViewModel) {
		self.addToDoItemButton.setTitle(model.title, for: .normal)
		self.addToDoItemButton.setTitleColor(model.normalTitleColor, for: .normal)
		self.addToDoItemButton.setTitleColor(model.disabledTitleColor, for: .disabled)
		self.addToDoItemButton.backgroundColor = model.backgroundColor
		self.addToDoItemButton.isEnabled = model.isEnabled
		self.addToDoItemButton.addAction {
			model.action()
		}
	}
}
