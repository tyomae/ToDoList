//
//  ListItemCellViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import Foundation

protocol ListItemCellViewModel {
	var itemTitle: String { get }
}

final class ListItemCellViewModelImpl: ListItemCellViewModel, CellViewModel {
	let itemTitle: String
	
	init(itemTitle: String) {
		self.itemTitle = itemTitle
	}
}
