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
	var isDone: Bool { get }
}

final class ListItemCellViewModelImpl: ListItemCellViewModel, CellViewModel {
	let itemTitle: String
	let itemNote: String
	let isDone: Bool
	
	init(itemTitle: String, itemNote: String, isDone: Bool) {
		self.itemTitle = itemTitle
		self.itemNote = itemNote
		self.isDone = isDone
	}
}
