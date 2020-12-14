//
//  ToDoInfoViewController.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

class ToDoInfoViewController: BaseViewController<ToDoInfoViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			self.tableView.registerNibs(for: [DateInputTableViewCell.self, ItemInfoTableViewCell.self, ButtonTableViewCell.self])
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Details"
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeVC))
	}
	
	override func setupViewModel() {
		self.viewModel = ToDoInfoViewModelImpl()
	}
	
	override func processViewModel(state: ToDoInfoViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.tableView.reloadData()
			case .allEntriesCorrect:
				self.closeVC()
		}
	}
	
	@objc func closeVC() {
		dismiss(animated: true, completion: nil)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel.sections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.viewModel.sections[section].title
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.sections[section].cellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellViewModel = self.viewModel.sections[indexPath.section].cellViewModels[indexPath.row]
		if let cellModel = cellViewModel as? DateInputViewModelImpl {
			let cell: DateInputTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		} else if let cellModel = cellViewModel as? ItemInfoCellViewModelImpl {
			let cell: ItemInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		} else if let cellModel = cellViewModel as? ButtonViewModelImpl {
			let cell: ButtonTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		}
		fatalError("Unknowned cellViewModel")
	}
}
