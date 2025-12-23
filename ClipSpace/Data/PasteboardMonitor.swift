//
//  PasteboardMonitor.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Data/System/PasteboardMonitor.swift

import AppKit
import Combine

final class PasteboardMonitor: PasteboardMonitorProtocol {
    private let pb = NSPasteboard.general
    private var changeCount = NSPasteboard.general.changeCount
    private var timer: AnyCancellable?
    private let repository: ClippingStoreProtocol
    private let settingsStore: SettingsStoreProtocol
    private var settings: AppSettings
    
    init(repository: ClippingStoreProtocol, settingsStore: SettingsStoreProtocol) {
        self.repository = repository
        self.settingsStore = settingsStore
        self.settings = settingsStore.load()
    }
    
    func start() {
        timer = Timer.publish(every: 0.3, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.tick() }
    }
    
    func stop() {
        timer?.cancel()
    }
    
    private func tick() {
        guard pb.changeCount != changeCount else { return }
        changeCount = pb.changeCount
        
        let front = NSWorkspace.shared.frontmostApplication?.bundleIdentifier ?? ""
        if settings.excludedBundleIDs.contains(front) { return }
        
        guard let str = pb.string(forType: .string),
              !str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        // Fetch all clippings
        let existing = repository.fetch(query: nil)
        
        // Prevent duplicates: skip if any clipping already has same content
        if existing.contains(where: { $0.content == str }) {
            print("Duplicate ignored: \(str)")
            return
        }
        
        // Add new clipping
        let clip = Clipping(content: str, sourceAppBundleID: front)
        repository.add(clip)
        repository.prune(limit: settings.maxItems)
        
        print("Copied items listed: \(repository.fetch(query: nil).count)")
    }
}
