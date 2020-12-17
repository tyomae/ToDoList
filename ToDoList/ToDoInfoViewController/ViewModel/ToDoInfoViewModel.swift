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
	
	init(toDoItem: ToDoItemEntity) {
		
		self.dateViewModel.selectedDate = toDoItem.date
		self.itemTitleViewModel.itemInfo = toDoItem.itemTitle
		self.itemNoteViewModel.itemInfo = toDoItem.itemNote
		
		self.addEntryViewModel = ButtonViewModelImpl(title: R.string.localizable.to_do()) { [weak self] in
			self?.addItemToDB(id: toDoItem.id)
		}
		
		self.sections = [
			Section(title: R.string.localizable.choose_date(), cellViewModels: [self.dateViewModel]),
			Section(title: R.string.localizable.what_you_want_to_do(), cellViewModels: [self.itemTitleViewModel]),
			Section(title: R.string.localizable.note(), cellViewModels: [self.itemNoteViewModel]),
			Section(title: nil, cellViewModels: [self.addEntryViewModel])
		]
		self.stateHandler?(.dataLoaded)
	}
	
	private func addItemToDB(id: String) {
		if self.itemTitleViewModel.itemInfo.isEmpty {
			self.itemTitleViewModel.itemInfo = R.string.localizable.new_to_do()
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

