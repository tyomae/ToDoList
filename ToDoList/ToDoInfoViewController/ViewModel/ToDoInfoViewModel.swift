//
//  ToDoInfoViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//
import Foundation

final class ToDoInfoViewModelImpl: ViewModel {
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?
	var isEditing: Bool
	private var toDoItemService = ToDoItemServiceImpl()
	
	struct Section {
		let title: String?
		let cellViewModels: [CellViewModel]
	}
	
	enum State {
		case dataLoaded
		case allEntriesCorrect
	}
	
	private var dateViewModel = DateInputViewModelImpl()
	private var itemTitleViewModel = ItemInfoCellViewModelImpl()
	private var itemNoteViewModel = ItemInfoCellViewModelImpl()
	private var addEntryViewModel: ButtonViewModel!
	
	init(toDoItem: ToDoItemEntity, isEditing: Bool) {
		self.isEditing = isEditing
		
		dateViewModel.selectedDate = toDoItem.date
		itemTitleViewModel.itemInfo = toDoItem.itemTitle
		itemNoteViewModel.itemInfo = toDoItem.itemNote
		
		self.addEntryViewModel = ButtonViewModelImpl(title: "TO DO") { [weak self] in
			self?.addItemToDB(id: toDoItem.id)
		}
		
		self.sections = [
			Section(title: "Choose date", cellViewModels: [dateViewModel]),
			Section(title: "What you want to do", cellViewModels: [itemTitleViewModel]),
			Section(title: "Note", cellViewModels: [itemNoteViewModel]),
			Section(title: nil, cellViewModels: [addEntryViewModel])
		]
		self.stateHandler?(.dataLoaded)
	}
	
	private func addItemToDB(id: String) {
		if self.itemTitleViewModel.itemInfo.isEmpty {
			self.itemTitleViewModel.itemInfo = "New To-Do"
		}
				
		let itemInfoEntry = ToDoItemEntity (id: id,
											date: self.dateViewModel.selectedDate.startOfDay,
											itemTitle: self.itemTitleViewModel.itemInfo,
											itemNote: self.itemNoteViewModel.itemInfo,
											isDone: false)
		self.toDoItemService.addItemToDB(toDoItem: itemInfoEntry)
		self.stateHandler?(.allEntriesCorrect)
	}
}

