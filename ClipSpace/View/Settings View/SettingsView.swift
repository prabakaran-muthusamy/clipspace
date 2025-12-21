//
//  SettingsView.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Features/Settings/SettingsView.swift

import SwiftUI

struct SettingsView: View {

    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "iphone")
                }

            ExceptionsSettingsView()
                .tabItem {
                    Label("Exceptions", systemImage: "list.bullet")
                }

            AboutSettingsView()
                .tabItem {
                    Label("About", systemImage: "gearshape")
                }
        }
        .padding(16)
        .frame(width: 280, height: 200)
    }
}
