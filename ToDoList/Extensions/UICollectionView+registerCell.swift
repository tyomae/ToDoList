//
//  UICollectionView+registerCell.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

extension UITableView {
	
	//  MARK: Registration
	
	func registerNib<T: UITableViewCell>(for cellClass: T.Type) {
		register(T.nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func registerNibs(for cellClasses: [UITableViewCell.Type]) {
		cellClasses.forEach { register($0.nib, forCellReuseIdentifier: $0.defaultReuseIdentifier) }
	}
	
	//  MARK: Dequeuing
	
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		return cell
	}
}

//  MARK: Reusable View

/// Indicates that a view can be reused provided it matches a provided identifier.
protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

//  MARK: Nib Loadable

protocol NibLoadableView: class {
	static var nib: UINib { get }
}

//  MARK: Reusable View Convenience

extension ReusableView where Self: UIView {
	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}

//  MARK: Nib Loadable Convenience

extension NibLoadableView where Self: UIView {
	static var nib: UINib {
		let nibName = String(describing: self)
		return UINib(nibName: nibName, bundle: nil)
	}
}

extension UITableViewCell: ReusableView, NibLoadableView {
	
}

