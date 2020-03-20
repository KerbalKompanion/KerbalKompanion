//
//  Gauge.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 20.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import Foundation
import SwiftUI

struct Gauge: View {
    var label: String
    var value: Double
    var max: Double
    var error: Double = 0.8
    
    var gauge: Double {
        return Double(self.value / self.max)
    }
    var body: some View {
        GeometryReader() { geo in
            VStack {
                HStack {
                    Text(self.label).font(.system(.subheadline, design: .monospaced)).bold()
                    Spacer()
                    // TODO: Fix this
                    Text(String(format: "%04.2f", self.value))
                        .font(.system(.callout, design: .monospaced)).bold()
                }.background(CS.shadow_dark).padding(0)

                Capsule()
                    .stroke(CS.main_bg, lineWidth: 4)
                    .shadow(color: CS.shadow_dark, radius: 3, x: 5, y: 5)
                    .clipShape(Capsule())
                    .shadow(color: CS.shadow_light, radius: 3, x: -5, y: -5)
                    .clipShape(Capsule())
                    .frame(width: geo.size.width, height: 20)
                    .overlay(
                        Capsule()
                            .frame(width: CGFloat(Double(geo.size.width) * self.gauge), height: 16)
                            .clipShape(Capsule())
                            .foregroundColor((self.gauge >= self.error) ? .red : .green)
                            .shadow(color: CS.shadow_light, radius: 8, x: -5, y: -5)
                            .shadow(color: CS.shadow_dark, radius: 8, x: 5, y: 5)
                        ,alignment: .leading
                ).padding(0)
            }
        }.padding()
    }
}
