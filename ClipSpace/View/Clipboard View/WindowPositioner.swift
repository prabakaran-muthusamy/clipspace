//
//  WindowPositioner.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 24/12/25.
//

import SwiftUI
import AppKit

struct WindowPositioner: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                NotificationCenter.default.addObserver(
                    forName: NSWindow.didBecomeKeyNotification,
                    object: window,
                    queue: .main
                ) { _ in
                    if let screen = window.screen {
                        let screenFrame = screen.visibleFrame
                        let windowSize = window.frame.size

                        // ✅ Align to left edge, flush with top
                        let x = screenFrame.minX + 12
                        let y = screenFrame.maxY - windowSize.height

                        window.setFrameOrigin(NSPoint(x: x, y: y))
                    }
                }
            }
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}


