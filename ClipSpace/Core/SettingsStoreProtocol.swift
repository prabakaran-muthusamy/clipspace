//
//  SettingsStoreProtocol.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Core/Protocols/SettingsStoreProtocol.swift

import Foundation

protocol SettingsStoreProtocol {
    func load() -> AppSettings
    func save(_ settings: AppSettings)
}
