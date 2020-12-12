//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import Foundation

final class ToDoViewModelImpl: ViewModel {
	
	struct Section {
		enum SectionType {
			case albumInfo
			case track
			case copyright
		}
		
		let cellViewModels: [CellViewModel]
		let type: SectionType
	}
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?

	
	enum State {
		case dataLoaded
	}

	init() {
		
	}
	

	

}
