//
//  DateInputViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

protocol DateInputViewModel: UITextFieldDelegate, CellViewModel {
	var selectedDate: Date { get }
	var formattedStringValue: String { get }
	var onSelectedDateChanged: (() -> Void)? { get set }
}

final class DateInputViewModelImpl: NSObject, DateInputViewModel, UITextFieldDelegate {

	var selectedDate: Date {
		didSet {
			self.onSelectedDateChanged?()
		}
	}
	
	var formattedStringValue: String {
		DateFormatter.common.string(from: self.selectedDate)
	}
	
	var onSelectedDateChanged: (() -> Void)?
	
	private let mode: UIDatePicker.Mode
	
	private var pickerViewModel: InputDatePickerViewModel {
		let viewModel = InputDatePickerViewModelImpl(
			onDateSelected: { [weak self] selectedDate in
				self?.selectedDate = selectedDate
			},
			mode: self.mode,
			defaultDate: self.selectedDate
		)
		return viewModel
	}
	
	private var inputDatePickerView: InputDatePickerView!
	
	init(defaultDate: Date = Date(), mode: UIDatePicker.Mode = .date) {
		self.selectedDate = defaultDate
		self.mode = mode
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.textColor = .systemIndigo
		textField.backgroundColor = .clear
		
		self.inputDatePickerView = InputDatePickerView(viewModel: self.pickerViewModel)
		textField.inputView = self.inputDatePickerView.datePicker
		textField.inputAccessoryView = DoneToolbar(activeControl: textField)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.backgroundColor = .systemGray5
		textField.textColor = .black
		textField.inputView = nil
		self.inputDatePickerView = nil
	}
}

