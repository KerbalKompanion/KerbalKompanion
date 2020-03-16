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
                Text("% "+String(format: "%02d%", Int(self.fuel.remaining * 100.0) ) )
                    .font(.system(.subheadline, design: .monospaced))
                Capsule().stroke()
                    .frame(width: 70, height: 15)
                    .overlay(
                        Capsule().frame(width: CGFloat(70 * self.fuel.remaining))
                        ,alignment: .leading)
            }
        }
    }
    
    struct Detail: View {
        @EnvironmentObject var telemachus: TelemachusClient
        var label: String
        var fuel: TelemachusData.Vessel.Ressource.Fuel
        var time: Date {
            return self.telemachus.data.universalTime
        }
        @State var newFuel: TelemachusData.Vessel.Ressource.Fuel? = nil
        @State var oldFuel: TelemachusData.Vessel.Ressource.Fuel? = nil
        
        @State var newTime: Date? = nil
        @State var oldTime: Date? = nil
        
        var fuelConsumption: Double {
            if self.oldTime == nil || self.oldFuel == nil || self.newTime == nil || self.newFuel == nil {
                return 0.0
            }
            let deltaFuel = self.oldFuel!.current - self.newFuel!.current
            let deltaTime = self.newTime!.timeIntervalSince(self.oldTime!)
            let consumption = deltaFuel / deltaTime
            return consumption
        }
        var body: some View {
            VStack {
                Text(label).font(.system(.subheadline, design: .monospaced)).bold()
                Divider()
                HStack {
                    Text("CURRENT").font(.system(.subheadline, design: .monospaced)).bold()
                    Spacer()
                    Text(String(format: "%05.2f",self.fuel.current)).font(.system(.callout, design: .monospaced))
                }
                HStack {
                    Text("MAXIMUM").font(.system(.subheadline, design: .monospaced)).bold()
                    Spacer()
                    Text(String(format: "%05.2f",self.fuel.max)).font(.system(.callout, design: .monospaced))
                }
                HStack {
                    Text("MILEAGE").font(.system(.subheadline, design: .monospaced)).bold()
                    Spacer()
                    Text(String(format: "%05.2f", self.fuelConsumption)).font(.system(.callout, design: .monospaced))
                }
            }.padding().background(RoundedBackground())
                .onReceive(self.telemachus.$data) { (output) in
                    self.oldFuel = self.newFuel
                    self.newFuel = self.fuel
                    self.oldTime = self.newTime
                    self.newTime = self.time
                }
        }
    }
}
