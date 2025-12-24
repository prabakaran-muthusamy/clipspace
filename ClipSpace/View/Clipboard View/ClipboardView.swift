//
//  ClipboardView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Features/Clipboard/ClipboardView.swift

import SwiftUI

struct ClipboardView: View {
    @EnvironmentObject var viewModel: ClipboardViewModel
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 8) {
                                   
            // Search bar
            SearchField(text: Binding(
                get: { viewModel.query },
                set: { viewModel.search($0) }
            ))
            
            // Two-column layout: left list (350), right detail (fills remaining)
            HStack(spacing: 0) {
                // Left: list with keyboard selection + hover preview
                List(Array(viewModel.clippings.enumerated()), id: \.element.id, selection: $viewModel.selection) { index, clip in
                    ClippingRow(clip: clip, index: index, viewModel: viewModel)
                    //.contentShape(Rectangle) // ensure hover hit-testing
                        .onHover { hovering in
                            if hovering { viewModel.setHoveredClip(clip) }
                            else if viewModel.hoveredClip?.id == clip.id { viewModel.setHoveredClip(nil) }
                        }
                }
                .listStyle(.plain)
                .frame(width: 350)           // fixed list column width
                .frame(maxHeight: .infinity) // fill vertical space
                .scrollIndicators(.hidden)
                .focusable(true)              // enables ↑/↓ navigation
                
                Divider()
                
                // Right: detail panel (only when hovering or selected)
                if let detail = viewModel.hoveredClip ?? viewModel.selection {
                    DetailPopoverView(clip: detail)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(8)
                        .transition(.opacity)
                } else {
                    // Keep layout stable without resizing the window
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            // Footer controls
            VStack(alignment: .leading) {
                Divider()
                Button("Clear All", role: .destructive) {
                    showDeleteAlert = true // trigger alert
                }
                .alert("Delete All Clips?", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) {
                    }
                    Button("Delete", role: .destructive) {
                        viewModel.deleteAll() }
                } message: {
                    Text("This will permanently remove all copied items.")
                }
                Divider()
                HStack {
                    Button("Preferences...") {
                        openPreferences()
                        NSApp.keyWindow?.performClose(nil)
                    }
                    Spacer()
                    Text("⌘,")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                Divider()
                Button("Quit", role: .destructive) {
                    NSApp.terminate(nil)
                }
            }
            .padding(.top, 8)
        }
        .padding(8)
        .frame(
            minHeight: min(viewModel.contentHeight, NSScreen.main?.visibleFrame.height ?? 600),
            maxHeight: NSScreen.main?.visibleFrame.height ?? 600
        )
        .frame(width: 700)
        //.background(WindowPositioner())
    }
    
    private func openPreferences() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    }
}

