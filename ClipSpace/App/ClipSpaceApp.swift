//
//  ClipSpaceApp.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 21/12/25.
//

import SwiftUI

@main
struct ClipSpaceApp: App {
    @StateObject private var clipboardVM: ClipboardViewModel
    @StateObject private var settingsVM: SettingsViewModel
    private let monitor: PasteboardMonitor

    init() {
        let repo = ClippingFileStore()
        let settings = SettingsUserDefaultsStore()
        _clipboardVM = StateObject(wrappedValue: ClipboardViewModel(repository: repo, settingsStore: settings))
        _settingsVM = StateObject(wrappedValue: SettingsViewModel(store: settings))
        monitor = PasteboardMonitor(repository: repo, settingsStore: settings)
        monitor.start()
    }

    var body: some Scene {
        MenuBarExtra("ClipSpace", systemImage: "clipboard") {
            ClipboardView()
                .environmentObject(clipboardVM)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
                .environmentObject(settingsVM)
                .environmentObject(clipboardVM)
        }
    }
}


