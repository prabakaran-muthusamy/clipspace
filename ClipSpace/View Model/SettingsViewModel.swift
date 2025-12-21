//
//  SettingsViewModel.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Features/Settings/SettingsViewModel.swift

import SwiftUI
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var settings: AppSettings
    private let store: SettingsStoreProtocol

    init(store: SettingsStoreProtocol) {
        self.store = store
        self.settings = store.load()
    }

    func save() { store.save(settings) }
    func addExclusion(_ bundleID: String) { settings.excludedBundleIDs.insert(bundleID); save() }
    func removeExclusion(_ bundleID: String) { settings.excludedBundleIDs.remove(bundleID); save() }
    func setMaxItems(_ value: Int) { settings.maxItems = value; save() }
    func toggleDock(_ show: Bool) { settings.showInDock = show; save() }
}

