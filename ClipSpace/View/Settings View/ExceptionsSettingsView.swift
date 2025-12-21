//
//  ExceptionsSettingsView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

import SwiftUI

struct ExceptionsSettingsView: View {

    @EnvironmentObject var settingsVM: SettingsViewModel
    @State private var bundleID: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack {
                TextField("Bundle ID (e.g. com.apple.Safari)", text: $bundleID)
                Button("Add") {
                    guard !bundleID.isEmpty else { return }
                    settingsVM.addExclusion(bundleID)
                    bundleID = ""
                }
            }

            List {
                ForEach(Array(settingsVM.settings.excludedBundleIDs).sorted(), id: \.self) { id in
                    HStack {
                        Text(id)
                        Spacer()
                        Button {
                            settingsVM.removeExclusion(id)
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

