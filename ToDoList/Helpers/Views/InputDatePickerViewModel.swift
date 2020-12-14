//
//  InputDatePickerViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

protocol InputDatePickerViewModel {
	var defaultDate: Date { get }
	var mode: UIDatePicker.Mode { get }
	var onDateSelected: ((Date) -> Void)? { get }
}

final class InputDatePickerViewModelImpl: InputDatePickerViewModel {
	let defaultDate: Date
	let mode: UIDatePicker.Mode
	var onDateSelected: ((Date) -> Void)?

	init(
		onDateSelected: @escaping (Date) -> Void,
		mode: UIDatePicker.Mode = .date,
		defaultDate: Date = Date()
	) {
		self.onDateSelected = onDateSelected
		self.mode = mode
		self.defaultDate = defaultDate
	}
}
