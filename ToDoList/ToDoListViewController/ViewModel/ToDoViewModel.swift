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
		
	}
	
	func process(action: Action) {
		switch action {
			case .deleteListItem:
				return
		}
	}
}
