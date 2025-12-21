//
//  Strings.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

import Foundation

extension String {
    var isSensitive: Bool {
        // crude checks: adjust as needed
        let lower = self.lowercased()
        if lower.contains("password") || lower.contains("otp") { return true }
        if self.count >= 6 && self.allSatisfy({ $0.isNumber }) { return true } // numeric OTP
        return false
    }
}
