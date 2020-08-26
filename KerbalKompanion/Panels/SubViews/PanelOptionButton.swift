//
//  PanelOptionButton.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI

struct PanelOptionButton: View {
    @Binding var status: Bool
    var label: LocalizedStringKey
    var body: some View {
        Button(action: { self.status.toggle() }) {
            HStack {
                Image(systemName: status ? "circle.fill" : "circle").animation(.spring())
                Text(label).font(.system(.body, design: .monospaced))
                Spacer()
            }
        }
    }
}


struct PanelOptionButton_Previews: PreviewProvider {
    static var previews: some View {
        PanelOptionButton(status: .constant(Bool.random()), label: "Some Label")
    }
}
