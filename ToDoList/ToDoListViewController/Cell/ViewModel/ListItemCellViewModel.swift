//
//  ListItemCellViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import Foundation

protocol ListItemCellViewModel {
	var itemTitle: String { get }
	var itemNote: String { get }
}

final class ListItemCellViewModelImpl: ListItemCellViewModel, CellViewModel {
	let itemTitle: String
	let itemNote: String
	
	init(itemTitle: String, itemNote: String) {
		self.itemTitle = itemTitle
		self.itemNote = itemNote
	}
}
