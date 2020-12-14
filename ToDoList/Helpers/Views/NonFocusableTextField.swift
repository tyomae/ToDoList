//
//  NonFocusableTextField.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

class NonFocusableTextField: UITextField {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}

	private func commonInit() {
		self.tintColor = .clear
	}

	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		false
	}

	override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
		[]
	}

	override func caretRect(for position: UITextPosition) -> CGRect {
		.zero
	}
}
