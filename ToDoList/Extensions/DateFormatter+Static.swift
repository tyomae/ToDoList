//
//  DateFormatter+Static.swift
//  ToDoList
//
//  Created by Артем  Емельянов  on 12.12.2020.
//

import Foundation

extension DateFormatter {
    static var common: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        return dateFormatter
    }()
}
