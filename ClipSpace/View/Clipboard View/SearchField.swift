//
//  SearchField.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// UIComponents/SearchField.swift
/// 
import SwiftUI

struct SearchField: View {
    @Binding var text: String
    var body: some View {
        TextField("Search the clip you want", text: $text)
            .textFieldStyle(.roundedBorder)
            .padding(.bottom, 4)
    }
}
