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
	private var toDoItemsDict = [Date : [ToDoItemEntity]]()
	private var toDoItemService = ToDoItemServiceImpl()
	
	struct Section {
		let date: String
		let cellViewModels: [ListItemCellViewModelImpl]
	}
	
	enum Action {
		case deleteItem(id: String)
		case toggleIsDone(toDoItemEntity: ToDoItemEntity)
	}
	
	enum State {
		case dataLoaded
	}
	
	init() {
		self.getSections()
		self.toDoItemService.addListener { [weak self] in
			self?.getSections()
			self?.stateHandler?(.dataLoaded)
		}
		self.stateHandler?(.dataLoaded)
	}
	
	func process(action: Action) {
		switch action {
			case .deleteItem(let id):
				self.toDoItemService.removeToDoFromDB(id: id)
			case .toggleIsDone(let toDoItemEntity):
				self.toDoItemService.toggleItemIsDone(toDoItem: toDoItemEntity)
				self.stateHandler?(.dataLoaded)
		}
	}
	
	func getItembyIndexPath(indexPath: IndexPath)-> ToDoItemEntity? {
		let keyByIndexPath = self.toDoItemsDict.keys.sorted()[indexPath.section]
		let toDoItemsByKey = self.toDoItemsDict[keyByIndexPath]
		return toDoItemsByKey?[indexPath.row]
	}
	
	private func getSections() {
		self.sections.removeAll()
		self.toDoItemsDict.removeAll()
		self.toDoItems = toDoItemService.getToDoItems()
		for item in toDoItems {
			let itemDate = item.date
			if self.toDoItemsDict[itemDate] != nil {
				self.toDoItemsDict[itemDate]?.append(item)
			} else {
				self.toDoItemsDict[itemDate] = [item]
			}
		}
		for key in self.toDoItemsDict.keys.sorted() {
			if let items = self.toDoItemsDict[key] {
				var listItemViewModels = [ListItemCellViewModelImpl]()
				for item in items {
					let itemViewModel = ListItemCellViewModelImpl(itemTitle: item.itemTitle,
																  itemNote: item.itemNote,
																  isDone: item.isDone)
					listItemViewModels.append(itemViewModel)
				}
				let stringKey = DateFormatter.common.string(from: key)
				self.sections.append(Section(date: stringKey, cellViewModels: listItemViewModels))
			}
		}
		self.stateHandler?(.dataLoaded)
	}
}
