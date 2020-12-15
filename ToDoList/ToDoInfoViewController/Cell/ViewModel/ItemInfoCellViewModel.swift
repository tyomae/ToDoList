//
//  ItemInfoCellViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

protocol ItemInfoCellViewModel: UITextViewDelegate, CellViewModel {
	var itemInfo: String { get }
}

final class ItemInfoCellViewModelImpl: NSObject, ItemInfoCellViewModel {
	var itemInfo: String = ""
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		textView.textColor = .systemIndigo
		textView.backgroundColor = .clear
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		textView.backgroundColor = .systemGray5
		textView.textColor = .black
		self.itemInfo = textView.text
	}
}
