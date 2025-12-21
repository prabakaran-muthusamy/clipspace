//
//  ClippingRow.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// UIComponents/ClippingRow.swift

import SwiftUI

struct ClippingRow: View {
    let clip: Clipping
    let index: Int
    @ObservedObject var viewModel: ClipboardViewModel
    
    var body: some View {
        HStack {
            if clip.content.isSensitive {
                SensitiveText(text: clip.content)
            } else {
                Text(clip.content)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button {
                viewModel.togglePin(clip)
            } label: {
                Image(systemName: clip.isPinned ? "pin.fill" : "pin")
            }
            .buttonStyle(.plain)
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(viewModel.hoveredClip?.id == clip.id ? Color(hex: "#094E9C") : Color.clear)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.selection = clip
            PasteService.paste(clip, asPlain: viewModel.pasteAsPlainText)
            NSApp.keyWindow?.performClose(nil)
        }
        .onHover { hovering in
            viewModel.setHoveredClip(hovering ? clip : nil)
        }
    }
}

