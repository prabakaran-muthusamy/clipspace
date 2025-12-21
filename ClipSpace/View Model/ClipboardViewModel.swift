//
//  ClipboardViewModel.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Features/Clipboard/ClipboardViewModel.swift

import SwiftUI
import Combine

final class ClipboardViewModel: ObservableObject {
    @Published var clippings: [Clipping] = []
    @Published var selection: Clipping?
    @Published var selectedIndex: Int? = nil
    @Published var query: String = ""
    @Published var pasteAsPlainText: Bool = false
    
    // Hover state used by the detail popover
    @Published var hoveredClip: Clipping? = nil
    private var hoverTask: DispatchWorkItem?
    
    // Your existing repository and settingsStore...
    private let repository: ClippingStoreProtocol
    private let settingsStore: SettingsStoreProtocol
    
    init(repository: ClippingStoreProtocol, settingsStore: SettingsStoreProtocol) {
        self.repository = repository
        self.settingsStore = settingsStore
        reload()
    }
    
    func search(_ q: String) {
        query = q
        reload()
    }
    
    func reload() {
        clippings = repository.fetch(query: query)
    }
    
    func togglePin(_ clip: Clipping) {
        var updated = clip
        updated.isPinned.toggle()
        repository.update(updated)
        reload()
    }
    
    func delete(_ clip: Clipping) {
        repository.delete(id: clip.id)
        reload()
    }
    
    func deleteAll() {
        repository.deleteAll()
        reload()
    }
    
    func pasteSelected() {
        guard let sel = selection else { return }
        PasteService.paste(sel, asPlain: pasteAsPlainText)
    }
    
    func pasteAtIndex(_ index: Int) {
        guard clippings.indices.contains(index) else { return }
        PasteService.paste(clippings[index], asPlain: pasteAsPlainText)
    }
    
    func updatePasteMode(_ asPlain: Bool) {
        pasteAsPlainText = asPlain
        var s = settingsStore.load()
        s.pasteAsPlainText = asPlain
        settingsStore.save(s)
    }
    
    func setHoveredClip(_ clip: Clipping?) {
        // Cancel any existing scheduled highlight
        hoverTask?.cancel()
        guard let clip = clip else {
            hoveredClip = nil
            return
        }
        // Schedule a delayed highlight
        let task = DispatchWorkItem { [weak self] in
            DispatchQueue.main.async {
                self?.hoveredClip = clip
            }
        }
        hoverTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: task) }
}

extension ClipboardViewModel {
    var contentHeight: CGFloat {
        let rowHeight: CGFloat = 28
        let basePadding: CGFloat = 60
        let count = clippings.count
        return CGFloat(count) * rowHeight + basePadding
    }
}
