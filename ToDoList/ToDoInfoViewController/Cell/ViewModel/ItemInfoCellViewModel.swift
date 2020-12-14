//
//  ItemInfoCellViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

protocol ItemInfoCellViewModel: UITextFieldDelegate, CellViewModel {
	var itemTitle: String? { get }
}

final class ItemInfoCellViewModelImpl: NSObject, ItemInfoCellViewModel {
	var itemTitle: String?
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.textColor = .systemIndigo
		textField.backgroundColor = .clear
		textField.inputAccessoryView = DoneToolbar(activeControl: textField)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.backgroundColor = .systemGray5
		textField.textColor = .black
		self.itemTitle = textField.text
	}
//	var itemTitle: String
//	var itemNote: String

}
