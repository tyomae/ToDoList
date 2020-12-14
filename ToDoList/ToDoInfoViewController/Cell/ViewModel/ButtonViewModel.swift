//
//  ButtonViewModel.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

protocol ButtonViewModel: CellViewModel {
	var title: String { get }
	var backgroundColor: UIColor { get }
	var normalTitleColor: UIColor { get }
	var disabledTitleColor: UIColor? { get }
	var isEnabled: Bool { get set }
	var action: (() -> Void) { get set }
}

final class ButtonViewModelImpl: ButtonViewModel {
	let title: String
	let backgroundColor: UIColor
	let normalTitleColor: UIColor
	var disabledTitleColor: UIColor? {
		self.normalTitleColor.darker(by: 20)
	}
	var isEnabled: Bool
	var action: (() -> Void)

	init(title: String, action: @escaping (() -> Void), backgroundColor: UIColor = .systemIndigo, titleColor: UIColor = .white, isEnabled: Bool = true) {
		self.title = title
		self.action = action
		self.backgroundColor = backgroundColor
		self.normalTitleColor = titleColor
		self.isEnabled = isEnabled
	}
}
