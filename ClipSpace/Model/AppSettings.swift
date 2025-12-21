//
//  AppSettings.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Core/Models/AppSettings.swift

import Foundation

struct AppSettings: Codable, Equatable {
    var maxItems: Int
    var displayItems: Int
    var launchAtLogin: Bool
    var isRecordingEnabled: Bool
    var pasteAsPlainText: Bool
    var excludedBundleIDs: Set<String>
    var showInDock: Bool
    var hotkeyOpen: Hotkey
    var hotkeyPasteTop: Hotkey
    
    // Default initializer
    init(
        maxItems: Int = 100,
        displayItems: Int = 80,
        launchAtLogin: Bool = true,
        isRecordingEnabled: Bool = true,
        pasteAsPlainText: Bool = true,
        excludedBundleIDs: Set<String> = [],
        showInDock: Bool = false,
        hotkeyOpen: Hotkey = Hotkey(key: .c, modifiers: [.option]),
        hotkeyPasteTop: Hotkey = Hotkey(key: .v, modifiers: [.option])
    ) {
        self.maxItems = maxItems
        self.displayItems = displayItems
        self.launchAtLogin = launchAtLogin
        self.isRecordingEnabled = isRecordingEnabled
        self.pasteAsPlainText = pasteAsPlainText
        self.excludedBundleIDs = excludedBundleIDs
        self.showInDock = showInDock
        self.hotkeyOpen = hotkeyOpen
        self.hotkeyPasteTop = hotkeyPasteTop
    }
    
    // Migration‑safe decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        maxItems = try container.decodeIfPresent(Int.self, forKey: .maxItems) ?? 100
        displayItems = try container.decodeIfPresent(Int.self, forKey: .displayItems) ?? 80
        launchAtLogin = try container.decodeIfPresent(Bool.self, forKey: .launchAtLogin) ?? true
        isRecordingEnabled = try container.decodeIfPresent(Bool.self, forKey: .isRecordingEnabled) ?? true
        pasteAsPlainText = try container.decodeIfPresent(Bool.self, forKey: .pasteAsPlainText) ?? true
        excludedBundleIDs = try container.decodeIfPresent(Set<String>.self, forKey: .excludedBundleIDs) ?? []
        showInDock = try container.decodeIfPresent(Bool.self, forKey: .showInDock) ?? false
        hotkeyOpen = try container.decodeIfPresent(Hotkey.self, forKey: .hotkeyOpen) ?? Hotkey(key: .c, modifiers: [.option])
        hotkeyPasteTop = try container.decodeIfPresent(Hotkey.self, forKey: .hotkeyPasteTop) ?? Hotkey(key: .v, modifiers: [.option])
    }
}
