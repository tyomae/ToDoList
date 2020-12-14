//
//  UIControl+Action.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

extension UIControl {
	typealias UIControlTargetClosure = () -> Void

	private class UIControlClosureWrapper: NSObject {
		let closure: UIControlTargetClosure

		init(_ closure: @escaping UIControlTargetClosure) {
			self.closure = closure
		}
	}

	private enum AssociatedKeys {
		static var targetClosure = "targetClosure"
	}

	private var targetClosure: UIControlTargetClosure? {
		get {
			guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else {
				return nil
			}
			return closureWrapper.closure
		}
		set(newValue) {
			guard let newValue = newValue else {
				return
			}
			objc_setAssociatedObject(
				self,
				&AssociatedKeys.targetClosure,
				UIControlClosureWrapper(newValue),
				objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
			)
		}
	}

	@objc
	func closureAction() {
		guard let targetClosure = targetClosure else {
			return
		}
		targetClosure()
	}

	func addAction(for controlEvents: UIControl.Event = .touchUpInside, closure: @escaping UIControlTargetClosure) {
		targetClosure = closure
		addTarget(self, action: #selector(UIControl.closureAction), for: controlEvents)
	}
}
