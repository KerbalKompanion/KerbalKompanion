//
//  RessourceView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

class RessourceView {
    struct Graph: View {
        var label: String
        var fuel: TelemachusData.Vessel.Ressource.Fuel
        
        var body: some View {
            HStack {
                Text(label).font(.system(.subheadline, design: .monospaced)).bold()
                Spacer()
                // TODO: Fix this
                Text( String(format: "%02d%", Int(self.fuel.max != 0 ? self.fuel.remaining * 100.0 : 0) ) )
                    .font(.system(.subheadline, design: .monospaced))
                Capsule().stroke()
                    .frame(width: 70, height: 15)
                    .overlay(
                        Capsule().frame(width: CGFloat(self.fuel.max != 0 ?  7.0*self.fuel.remaining : 0))
                        ,alignment: .leading)
            }
        }
    }
}
