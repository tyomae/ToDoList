//
//  DateInputTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

class DateInputTableViewCell: UITableViewCell, ConfigurableView {

	@IBOutlet weak var dateTextField: UITextField!
	
	func configure(with model: DateInputViewModel) {
		self.dateTextField.text = model.formattedStringValue
		self.dateTextField.delegate = model
		model.onSelectedDateChanged = { [weak self] in
			self?.dateTextField?.text = model.formattedStringValue
		}
	}
}
