//
//  Hotkey.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Core/Models/Hotkey.swift

import Foundation

struct Hotkey: Codable, Equatable {
    enum Key: UInt16, Codable {
        case a = 0, c = 8, v = 9, one = 18, two = 19, three = 20
        // add more as needed
    }

    struct Modifier: OptionSet, Equatable {
        let rawValue: Int

        static let command = Modifier(rawValue: 1 << 0)
        static let option  = Modifier(rawValue: 1 << 1)
        static let shift   = Modifier(rawValue: 1 << 2)
        static let control = Modifier(rawValue: 1 << 3)
    }

    var key: Key
    var modifiers: Modifier
}

// Make Modifier Codable manually
extension Hotkey.Modifier: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(Int.self)
        self.init(rawValue: raw)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
