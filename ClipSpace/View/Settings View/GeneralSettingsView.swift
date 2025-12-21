//
//  GeneralSettingsView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

import SwiftUI

struct GeneralSettingsView: View {

    @EnvironmentObject var settingsVM: SettingsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            // Remember
            HStack {
                Text("Remember:")
                NumericField(value: $settingsVM.settings.maxItems)
                Text("clippings")
            }

            // Display
            HStack {
                Text("Display:")
                NumericField(value: $settingsVM.settings.displayItems)
                Text("clippings")
            }

            Divider()

            Toggle("Start ClipSpace at system startup",
                   isOn: $settingsVM.settings.launchAtLogin)

            Toggle("Should record clips",
                   isOn: $settingsVM.settings.isRecordingEnabled)

            Spacer()
        }
        .padding(.top, 6)
    }
}
