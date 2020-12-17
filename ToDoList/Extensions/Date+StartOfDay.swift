//
//  Date+GetDate.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 17.12.2020.
//

import Foundation

extension Date {

	var startOfDay: Date {
		return Calendar.current.startOfDay(for: self)
	}
}
