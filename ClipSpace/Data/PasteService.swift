//
//  PasteService.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Data/System/PasteService.swift

import AppKit

enum PasteService {
    static func paste(_ clipping: Clipping, asPlain: Bool) {
        let pb = NSPasteboard.general
        pb.clearContents()
        if asPlain {
            pb.setString(clipping.content, forType: .string)
        } else if let rtf = clipping.richRTF {
            pb.setData(rtf, forType: .rtf)
        } else {
            pb.setString(clipping.content, forType: .string)
        }
        sendCmdV()
    }

    private static func sendCmdV() {
        let src = CGEventSource(stateID: .hidSystemState)
        let down = CGEvent(keyboardEventSource: src, virtualKey: 9, keyDown: true)! // kVK_ANSI_V
        let up = CGEvent(keyboardEventSource: src, virtualKey: 9, keyDown: false)!
        down.flags = .maskCommand
        up.flags = .maskCommand
        down.post(tap: .cghidEventTap)
        up.post(tap: .cghidEventTap)
    }
}
