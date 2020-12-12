//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 11.12.2020.
//

import UIKit

class ToDoListViewController: BaseViewController<ToDoViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			self.tableView.registerNib(for: ListItemTableViewCell.self)
		}
	}
	@IBOutlet weak var emptyListLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        
    }

	override func setupViewModel() {
		self.viewModel = ToDoViewModelImpl()
	}
	
	// MARK: - UITableViewDataSource
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
