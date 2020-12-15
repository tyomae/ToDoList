//
//  DoneToolbar.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import UIKit

class DoneToolbar: UIToolbar {
	weak var activeControl: UIView?

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}

	init(activeControl: UIView) {
		super.init(frame: .zero)
		self.activeControl = activeControl
		self.commonInit()
	}

	private func commonInit() {
		self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
		self.items = [
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
		]
		self.tintColor = .systemIndigo
	}

	@objc
	private func done() {
		self.activeControl?.endEditing(true)
	}
}
