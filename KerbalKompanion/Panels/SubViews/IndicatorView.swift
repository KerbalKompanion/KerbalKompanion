//
//  IndicatorView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI

class IndicatorView {
    struct Blinking: View {
        var status:Bool
        var label: String
        var trueLight: Color
        var falseLight: Color
        @State var blinkingToggle: Bool = false
        var timer: Timer {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {_ in
                self.blinkingToggle.toggle()
            }
        }

        var body: some View {
            HStack() {
                Image(systemName: "circle")
                    .imageScale(.large)
                    .background(Image(systemName: "circle.fill").imageScale(.large).foregroundColor(status ? (blinkingToggle ? trueLight : falseLight) : falseLight))
                Text(label).font(.system(.subheadline, design: .monospaced))
            }.onAppear(perform: {
                _ = self.timer
            })
        }
    }

    struct Static: View {
        var status:Bool
        var label: String
        var trueLight: Color
        var falseLight: Color

        var body: some View {
            HStack {
                Image(systemName: "circle")
                    .imageScale(.large)
                    .background(Image(systemName: "circle.fill").imageScale(.large).foregroundColor(status ? trueLight : falseLight))
                Text(label).font(.system(.subheadline, design: .monospaced))
            }
        }
    }
}
