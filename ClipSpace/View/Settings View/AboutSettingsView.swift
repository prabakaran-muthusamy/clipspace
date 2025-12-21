//
//  AboutSettingsView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//


import SwiftUI

struct AboutSettingsView: View {

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "doc.on.clipboard")
                .font(.system(size: 40))

            Text("ClipSpace")
                .font(.headline)

            Text("Free clipboard manager for macOS")
                .foregroundColor(.secondary)

            Text("Version 1.0.0")
                .font(.caption)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
