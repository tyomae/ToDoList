//
//  ToDoInfoViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

final class ToDoInfoViewModelImpl: ViewModel {
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?
	
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
	
	init() {
		self.addEntryViewModel = ButtonViewModelImpl(title: "TO DO") { [weak self] in
			self?.addItemToDB()
		}
		self.sections = [
			Section(title: "Choose date", cellViewModels: [dateViewModel]),
			Section(title: "What you want to do", cellViewModels: [itemTitleViewModel]),
			Section(title: "Note", cellViewModels: [itemNoteViewModel]),
			Section(title: nil, cellViewModels: [addEntryViewModel])
		]
		self.stateHandler?(.dataLoaded)
	}
	
	private func addItemToDB() {
		if self.itemTitleViewModel.itemInfo.isEmpty {
			self.itemTitleViewModel.itemInfo = "New To-Do"
		}
		let itemInfoEntry = ToDoItemEntity (stringDate: self.dateViewModel.formattedStringValue,
											itemTitle: self.itemTitleViewModel.itemInfo,
											itemNote: self.itemNoteViewModel.itemInfo)
		realmWrite {
			mainRealm.add(itemInfoEntry)
		}
		self.stateHandler?(.allEntriesCorrect)
	}
}

