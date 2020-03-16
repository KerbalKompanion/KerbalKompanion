//
//  ActionGroupView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct ActionGroupControll: View {
    @EnvironmentObject var telemachus: TelemachusClient
    var body: some View {
        VStack(alignment: .center) {
            Text("Action Groups").font(.system(.title, design: .monospaced))
            HStack {
                Spacer()
                VStack {
                    HStack(spacing: 0) {
                        ControllButton(ag: .actionGroup01).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup02).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup03).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup04).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup05).environmentObject(self.telemachus)
                    }
                    HStack(spacing: 0) {
                        ControllButton(ag: .actionGroup06).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup07).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup08).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup09).environmentObject(self.telemachus)
                        ControllButton(ag: .actionGroup10).environmentObject(self.telemachus)
                    }
                }
                Spacer()
            }
        }.foregroundColor(.primary)
        .padding()
        .background(RoundedBackground(isInner: true))
    }
}

