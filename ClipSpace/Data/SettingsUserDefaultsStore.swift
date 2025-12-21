//
//  SettingsUserDefaultsStore.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Data/Persistence/SettingsUserDefaultsStore.swift

import Foundation

final class SettingsUserDefaultsStore: SettingsStoreProtocol {
    private let key = "ClipSpace.settings"
    private let defaults = UserDefaults.standard

    func load() -> AppSettings {
        guard let data = defaults.data(forKey: key) else {
            return AppSettings()
        }
        do {
            return try JSONDecoder().decode(AppSettings.self, from: data)
        } catch {
            print("Failed to decode settings: \(error)")
            return AppSettings()
        }
    }

    func save(_ settings: AppSettings) {
        do {
            let data = try JSONEncoder().encode(settings)
            defaults.set(data, forKey: key)
        } catch {
            print("Failed to encode settings: \(error)")
        }
    }
}
