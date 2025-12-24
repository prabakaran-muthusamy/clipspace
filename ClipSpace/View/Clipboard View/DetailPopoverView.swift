//
//  DetailPopoverView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 21/12/25.
//

import SwiftUI

struct DetailPopoverView: View {
    let clip: Clipping
    let date: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(clip.content)
                .font(.body)
                .lineLimit(nil)
            
            HStack {
                // Left side
                VStack(alignment: .leading, spacing: 4) {
                    Text("Copied from")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Text(clip.sourceAppBundleID ?? "Unknown")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Right side
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Copied at")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Text(DateFormatterHelper.shared.formattedDate(clip.createdAt))
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
            //                .fill(Color(.windowBackgroundColor))
                .fill(Color(hex: "#2A84F2"))
        )
         .frame(maxWidth: 320)
    }
}
