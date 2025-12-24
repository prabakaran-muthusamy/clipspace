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
    
    var isActive: Bool {
        // Active if either keyboard selection or hover matches this row
        (viewModel.selection?.id == clip.id) || (viewModel.hoveredClip?.id == clip.id)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            // Content
            if clip.content.isSensitive {
                SensitiveText(text: clip.content)
            } else {
                Text(clip.content)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Pin button
            Button {
                viewModel.togglePin(clip)
            } label: {
                Image(systemName: clip.isPinned ? "pin.fill" : "pin") }
            .buttonStyle(.plain)
            
            // Delete button
            Button { viewModel.delete(clip)
            } label: {
                Image(systemName: "trash")
                .foregroundColor(.red) }
            .buttonStyle(.plain)
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(viewModel.hoveredClip?.id == clip.id ? Color(hex: "#2A84F2") : Color.clear)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.selection = clip
            
            let pb = NSPasteboard.general
            pb.clearContents()
            pb.setString(clip.content, forType: .string)
        }
    }
}
