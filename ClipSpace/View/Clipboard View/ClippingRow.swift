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
            Spacer()
            Button(action: { viewModel.togglePin(clip) }) {
                Image(systemName: clip.isPinned ? "pin.fill" : "pin")
            }
            .buttonStyle(.borderless)
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(viewModel.selectedIndex == index ? Color(hex: "#094E9C") : Color.clear)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.selectedIndex = index
            viewModel.selection = clip
            PasteService.paste(clip, asPlain: viewModel.pasteAsPlainText)
            // Close the menu bar window only (not hide the entire app)
            NSApp.keyWindow?.performClose(nil)
        }
        .onHover { hovering in
            if hovering {
                viewModel.setHoveredClip(clip)
            } else {
                viewModel.setHoveredClip(nil)
            }
        }
    }
}


