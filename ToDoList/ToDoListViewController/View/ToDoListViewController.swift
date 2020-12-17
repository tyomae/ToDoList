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
			self.emptyListLabel.isHidden = true
		}
	}
	@IBOutlet weak var titleView: UIView! {
		didSet {
			titleView.layer.cornerRadius = 26
			titleView.clipsToBounds = true
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "To-Do-List"
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
		}
	}
	
	@IBAction func addListItem(_ sender: UIButton) {
		self.openInfoItemVC(todoItem: ToDoItemEntity(id: UUID().uuidString,
													 date: Date(),
													 itemTitle: "",
													 itemNote: "",
													 isDone: false),
							isEditing: false)
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
			let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
				self.openInfoItemVC(todoItem: currentToDoItem,
									isEditing: true)
			}
			let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
				self.viewModel.process(action: .deleteItem(id: currentToDoItem.id))
			}
			let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
			
			return swipeActions
		}
		return nil
	}
	
	private func openInfoItemVC(todoItem: ToDoItemEntity, isEditing: Bool) {
		let vc = ToDoInfoViewController()
		let viewModel = ToDoInfoViewModelImpl(toDoItem: todoItem,
											  isEditing: isEditing)
		vc.viewModel = viewModel
		let navigationController = UINavigationController(rootViewController: vc)
		present(navigationController, animated: true, completion: nil)
	}
}


