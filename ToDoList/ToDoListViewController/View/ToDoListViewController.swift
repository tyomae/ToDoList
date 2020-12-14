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
		//TODO: delete
//		self.showAddCounterAlert()
		self.openInfoItemVC()
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
		self.openInfoItemVC()
	}
	
	private func openInfoItemVC() {
		let vc = ToDoInfoViewController()
		let navigationController = UINavigationController(rootViewController: vc)
		present(navigationController, animated: true, completion: nil)
	}

	
	// TODO: delete or not
//	private func showAddCounterAlert() {
//		let alertController = UIAlertController(title: "Add New To Do", message: "", preferredStyle: UIAlertController.Style.alert)
//		alertController.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//		alertController.addTextField { (textField : UITextField!) -> Void in
//			textField.placeholder = "Enter what you shold to do"
//		}
//		let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
//			guard let textField  = alertController.textFields?.first else { return }
//			guard let text = textField.text, !text.isEmpty else { return }
////			self.addListItem(title: text)
//			self.viewModel.process(action: .addListItem(itemTitle: text))
//		})
//		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: {
//			(action : UIAlertAction!) -> Void in })
//
//		alertController.addAction(cancelAction)
//		alertController.addAction(saveAction)
//
//		self.present(alertController, animated: true, completion: nil)
//	}
}


