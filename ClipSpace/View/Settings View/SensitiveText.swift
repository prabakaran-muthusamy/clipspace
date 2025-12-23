//
//  SensitiveText.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

import SwiftUI

struct SensitiveText: View {
    let text: String
    @State private var isHovering = false

    var body: some View {
        Text(isHovering ? text : String(repeating: "•", count: min(text.count, 8)))
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onHover { hovering in
                isHovering = hovering
            }
    }
}
