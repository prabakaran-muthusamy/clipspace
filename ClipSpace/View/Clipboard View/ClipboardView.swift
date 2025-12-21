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
    
    var body: some View {
        VStack(spacing: 8) {
            // Search bar
            SearchField(text: Binding(
                get: { viewModel.query },
                set: { viewModel.search($0) }
            ))
            
            // Scrollable list of clippings with hover detail
            ZStack(alignment: .topLeading) {
                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(Array(viewModel.clippings.enumerated()), id: \.element.id) { index, clip in
                            ClippingRow(clip: clip, index: index, viewModel: viewModel)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxHeight: .infinity)
                .focusable()
                
                // Floating detail view (simple placement; see note below for precise positioning)
                if let hovered = viewModel.hoveredClip {
                    DetailPopoverView(clip: hovered)
                        .transition(.opacity)
                        .zIndex(1)
                        .padding(.top, 4)
                        .padding(.leading, 8)
                }
            }
            
            // Footer controls
            VStack(alignment: .leading) {
                Divider()
                Button("Clear All", role: .destructive) {
                    viewModel.deleteAll()
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
        .frame(width: 400)
    }
    
    private func openPreferences() {
        // Triggers the SwiftUI Settings scene. ⌘, also uses this automatically.
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    }
}
