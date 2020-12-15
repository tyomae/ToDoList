//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import Foundation

final class ToDoViewModelImpl: ViewModel {
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?
	var toDoItems = [ToDoItemEntity]()
	var cellViewModels = [ListItemCellViewModel]()
	var toDoItemService = ToDoItemServiceImpl()
	
	struct Section {
		let date: String
		let cellViewModels: [ListItemCellViewModelImpl]
	}

	enum Action {
		case deleteListItem
	}
	
	enum State {
		case dataLoaded
	}

	init() {
		
		self.toDoItemService.addListener { [weak self] in
			self?.updateCellViewModels()
			self?.stateHandler?(.dataLoaded)
//			self?.stateHandler?(.emptyList)
		}
	}
	
	func process(action: Action) {
		switch action {
			case .deleteListItem:
				return
		}
	}
	
	private func updateCellViewModels() {
		self.toDoItems = toDoItemService.getToDoItems()
		self.cellViewModels.removeAll()
		for item in self.toDoItems {
			let cellViewModel = ListItemCellViewModelImpl(itemTitle: item.itemTitle, itemNote: item.itemNote)
			self.cellViewModels.append(cellViewModel)
		}
		self.stateHandler?(.dataLoaded)
	}
}
