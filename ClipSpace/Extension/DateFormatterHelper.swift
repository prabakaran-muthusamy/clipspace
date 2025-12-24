//
//  DateFormatterHelper.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 23/12/25.
//

import Foundation

final class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    private let calendar = Calendar.current

    private init() {}

    func formattedDate(_ date: Date) -> String {
        let formatter = Foundation.DateFormatter() // ✅ use real DateFormatter

        if calendar.isDateInToday(date) {
            formatter.dateFormat = "'Today,' HH:mm:ss"
            return formatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            formatter.dateFormat = "'Yesterday,' HH:mm:ss"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "EEEE, HH:mm:ss"
            return formatter.string(from: date)
        }
    }
}
