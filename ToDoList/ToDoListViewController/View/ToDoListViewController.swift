//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

class ToDoListViewController: BaseViewController<ToDoViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			self.tableView.registerNib(for: ListItemTableViewCell.self)
		}
	}
	@IBOutlet weak var emptyListLabel: UILabel! {
		didSet {
			self.emptyListLabel.text = R.string.localizable.empty_list()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = R.string.localizable.to_do_list()
		self.tableView.dataSource = self
		self.tableView.delegate = self
	}
	
	override func setupViewModel() {
		self.viewModel = ToDoViewModelImpl()
	}
	
	override func processViewModel(state: ToDoViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.tableView.reloadData()
				self.emptyListLabel.isHidden = !viewModel.toDoItems.isEmpty
		}
	}
	
	@IBAction func addListItem(_ sender: UIButton) {
		self.openInfoItemVC(todoItem: ToDoItemEntity(id: UUID().uuidString,
													 date: Date(),
													 itemTitle: "",
													 itemNote: "",
													 isDone: false))
	}
	
	// MARK: - UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel.sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.sections[section].cellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.viewModel.sections[section].date
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell: ListItemTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let cellViewModel = self.viewModel.sections[indexPath.section].cellViewModels[indexPath.row]
		cell.configure(with: cellViewModel)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		if let currentToDoItem = self.viewModel.getItembyIndexPath(indexPath: indexPath) {
			self.viewModel.process(action: .toggleIsDone(toDoItemEntity: currentToDoItem))
		}
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		if let currentToDoItem = self.viewModel.getItembyIndexPath(indexPath: indexPath) {
			let editAction = UIContextualAction(style: .normal, title: R.string.localizable.edit()) { _, _, _ in
				self.openInfoItemVC(todoItem: currentToDoItem)
			}
			let deleteAction = UIContextualAction(style: .destructive, title: R.string.localizable.delete()) { _,_,_ in
				self.viewModel.process(action: .deleteItem(id: currentToDoItem.id))
			}
			let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
			
			return swipeActions
		}
		return nil
	}
	
	private func openInfoItemVC(todoItem: ToDoItemEntity) {
		let vc = ToDoInfoViewController()
		let viewModel = ToDoInfoViewModelImpl(toDoItem: todoItem)
		vc.viewModel = viewModel
		let navigationController = UINavigationController(rootViewController: vc)
		present(navigationController, animated: true, completion: nil)
	}
}


