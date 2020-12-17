//
//  DateInputTableViewCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

class DateInputTableViewCell: UITableViewCell, ConfigurableView {

	@IBOutlet weak var dateTextField: UITextField! {
		didSet {
			self.dateTextField.layer.borderWidth = 1
			self.dateTextField.layer.borderColor = UIColor.systemGray4.cgColor
			self.dateTextField.layer.cornerRadius = 4
			self.dateTextField.layer.masksToBounds = true
		}
	}
	
	func configure(with model: DateInputViewModel) {
		self.dateTextField.text = model.formattedStringValue
		self.dateTextField.delegate = model
		model.onSelectedDateChanged = { [weak self] in
			self?.dateTextField?.text = model.formattedStringValue
		}
	}
}
