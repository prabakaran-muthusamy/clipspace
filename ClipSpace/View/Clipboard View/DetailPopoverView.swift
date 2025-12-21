//
//  DetailPopoverView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 21/12/25.
//

import SwiftUI

struct DetailPopoverView: View {
    let clip: Clipping

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(clip.content)
                .font(.body)
                .lineLimit(nil)
            
            if let app = clip.sourceAppBundleID, !app.isEmpty {
                Text("Copied from: \(app)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text("Saved at: \(clip.createdAt.formatted(.dateTime.hour().minute().second()))")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.windowBackgroundColor))
        )
        .shadow(radius: 4)
        .frame(maxWidth: 320)
    }
}
