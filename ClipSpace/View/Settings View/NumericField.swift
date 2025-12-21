//
//  NumericField.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

import SwiftUI

struct NumericField: View {

    @Binding var value: Int

    var body: some View {
        TextField("", value: $value, format: .number)
            .frame(width: 60)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
    }
}
