//
//  HotkeyService.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Data/System/HotkeyService.swift

import Cocoa

final class HotkeyService {
    private var monitorOpen: Any?
    private var monitorPasteTop: Any?
    private let onOpen: () -> Void
    private let onPasteTop: () -> Void

    init(onOpen: @escaping () -> Void, onPasteTop: @escaping () -> Void) {
        self.onOpen = onOpen
        self.onPasteTop = onPasteTop
    }

    func start() {
        monitorOpen = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] ev in
            guard ev.modifierFlags.contains(.option) && ev.modifierFlags.contains(.shift) else { return }
            if ev.keyCode == 8 { self?.onOpen() } // C
        }
        monitorPasteTop = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] ev in
            guard ev.modifierFlags.contains(.option) && ev.modifierFlags.contains(.shift) else { return }
            if ev.keyCode == 9 { self?.onPasteTop() } // V
        }
    }

    func stop() {
        if let m = monitorOpen { NSEvent.removeMonitor(m) }
        if let m = monitorPasteTop { NSEvent.removeMonitor(m) }
    }
}
