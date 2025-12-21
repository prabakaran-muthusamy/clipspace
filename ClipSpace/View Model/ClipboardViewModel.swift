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
    
    func togglePin(_ clip: Clipping) {
        // Your pin logic...
    }
    
    func deleteAll() {
        // Your delete logic...
        reload()
    }
    
    func updatePasteMode(_ flag: Bool) {
        pasteAsPlainText = flag
    }
    
    func reload() {
        clippings = repository.fetch(query: query)
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
    // Dynamic content height used to size the window initially
    var contentHeight: CGFloat {
        let rowHeight: CGFloat = 28   // tune to match your row layout
        let basePadding: CGFloat = 96 // search + footer + spacing
        return CGFloat(clippings.count) * rowHeight + basePadding
    }
}
