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
	
//	private func addListItem(title: String) {
//		
//		//TODO: delete
////		self.sections.append(Section(date: "\(Date())", cellViewModels: [ListItemCellViewModelImpl(itemTitle: title)]))
//		self.addItemToDB()
//		self.stateHandler?(.dataLoaded)
//	}
	
	private func addItemToDB() {
//		self.dateViewModel.selectedDate
//		
//		let diaryEntry = DiaryEntryEntity(
//			smokedObjectType: smokedObject,
//			smokedCount: smokedCount,
//			entryDate: self.dateViewModel.selectedDate,
//			desireToSmoke: Int(self.smokeDesireViewModel.currentValue.rounded()),
//			cravingsCount: Int(self.cravingsViewModel.currentValue)
//		)
//		realmWrite {
//			mainRealm.add(diaryEntry)
//		}
		self.stateHandler?(.allEntriesCorrect)
	}
}

