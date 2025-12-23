//
//  WindowPositioner.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 23/12/25.
//

import SwiftUI

struct WindowPositioner: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window, let screen = window.screen {
                let screenFrame = screen.visibleFrame
                let windowSize = window.frame.size
                
                let x = screenFrame.maxX - windowSize.width - 12
                let y = screenFrame.maxY - windowSize.height
                
                window.setFrameOrigin(NSPoint(x: x, y: y))
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
