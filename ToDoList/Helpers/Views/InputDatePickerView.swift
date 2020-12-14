//
//  InputDatePickerView.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

class InputDatePickerView: UIView {
	private(set) weak var datePicker: UIDatePicker! 
	private var viewModel: InputDatePickerViewModel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}
	
	init(viewModel: InputDatePickerViewModel) {
		super.init(frame: .zero)
		self.viewModel = viewModel
		self.commonInit()
	}
	
	private func commonInit() {
		let picker = UIDatePicker()
		self.addSubview(picker)
		self.datePicker = picker
		
		picker.date = self.viewModel.defaultDate
		picker.datePickerMode = self.viewModel.mode
		picker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
		if #available(iOS 14, *) {
			picker.preferredDatePickerStyle = .wheels
		}
		
		picker.translatesAutoresizingMaskIntoConstraints = false
		picker.topAnchor.constraint(equalTo: topAnchor).isActive = true
		picker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		picker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		picker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	@objc
	private func datePickerValueChanged(datePicker: UIDatePicker) {
		self.viewModel.onDateSelected?(datePicker.date)
	}
}
