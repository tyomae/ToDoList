//
//  UIColor+darker.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 14.12.2020.
//

import UIKit

extension UIColor {

	func darker(by percentage: CGFloat = 30.0) -> UIColor? {
		self.adjust(by: -1 * abs(percentage) )
	}

	func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
		var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return UIColor(
				red: min(red + percentage / 100, 1.0),
				green: min(green + percentage / 100, 1.0),
				blue: min(blue + percentage / 100, 1.0),
				alpha: alpha
			)
		} else {
			return nil
		}
	}
}
