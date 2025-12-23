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
    @Published var query: String = ""
    @Published var selection: Clipping? = nil
    // keyboard selection
    @Published var hoveredClip: Clipping? = nil
    // mouse hover
    @Published var contentViewHeight: CGFloat = 600
    private var hoverTask: DispatchWorkItem?
    
    @Published var selectedIndex: Int? = nil
    @Published var pasteAsPlainText: Bool = false
    private var shouldDelayHover = true
    
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
        clippings.removeAll()
        selection = nil
        hoveredClip = nil
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
    
    func resetHoverDelay() {
        shouldDelayHover = true
    }
    
    func setHoveredClip(_ clip: Clipping?) {
        hoverTask?.cancel()
        hoveredClip = clip
        guard let clip = clip else {
            hoveredClip = nil
            return
        }
        if shouldDelayHover {
            let task = DispatchWorkItem { [weak self] in
                DispatchQueue.main.async {
                    self?.hoveredClip = clip
                    self?.shouldDelayHover = false
                }
            }
            hoverTask = task
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: task) } else {
                hoveredClip = clip
            }
    }
}

extension ClipboardViewModel {
    var contentHeight: CGFloat {
        let rowHeight: CGFloat = 28
        let basePadding: CGFloat = 60
        let count = clippings.count
        return CGFloat(count) * rowHeight + basePadding
    }
}
