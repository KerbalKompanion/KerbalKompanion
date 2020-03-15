//
//  TopPanel.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit
struct TopPanel: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @Binding var showSettings: Bool
    var data: TelemachusData {
        return self.telemachus.data
    }
    @State var showHeightFromTerrain: Bool = true
    
    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 25) {
                //MARK: CONNECTION STATUS
                Button(action: {
                    self.telemachus.connect(self.settings.ip, self.settings.port) {
                        self.telemachus.subscribeTo(TelemachusClient.ApiKey.allCases)
                    }
                }) {
                    VStack {
                        Text(" ").overlay(
                            Image(systemName: "dot.radiowaves.left.and.right")
                        )
                        .font(.largeTitle)
                        .accentColor(self.telemachus.isConnected ? .primary : .red)
                            
                        Text(self.telemachus.isConnected ? "CONNECTED" : "DISCONNECTED")
                            .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
                    }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                }.buttonStyle(NMButton())
                
                //MARK: ALTITUDE INDICATOR
                Button(action: {
                    self.showHeightFromTerrain.toggle()
                }) {
                    VStack {
                        Text(String(format: "%06d", Int(self.showHeightFromTerrain ? data.vessel.heightFromTerrain : data.vessel.altitude))+" m" )
                            .font(.system(.largeTitle, design: .monospaced))
                            .accentColor(.primary)
                        Text(self.showHeightFromTerrain ? "HEIGHT FROM TERRAIN" : "ALTITUDE")
                            .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
                    }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                }.buttonStyle(NMButton())
                
                //MARK: HEADING INDICATOR
                VStack {
                    Text(String(format: "%03d", Int(data.vessel.attitude.heading)))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(.primary)
                    Text("HDG °").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                
                //MARK: VELOCITY INDICATOR
                VStack {
                    Text(String(format: "%04d", Int(data.vessel.speed.surface)))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(.primary)
                    Text("SURF SPD (m/s)").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                
                //MARK: PITCH INDICATOR
                VStack {
                    Text(String(format: "%03d", Int(data.vessel.attitude.pitch)))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(.primary)
                    Text("PITCH (°)").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                
                //MARK: VERTICAL SPEEDOMETER
                VStack {
                    Text(String(format: "%04d", abs(Int(data.vessel.speed.vertical))))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(data.vessel.speed.vertical < 0 ? .red : .primary)
                    Text("VERT SPD (m/s)").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                Spacer()
                
                //MARK: PREFERENCES
                Button(action: {
                    self.showSettings.toggle()
                }) {
                    VStack {
                        Text(" ").overlay(
                            Image(systemName: "gear")
                        )
                        .font(.largeTitle)
                            .accentColor(.primary)
                            
                        Text("PREFERENCES")
                            .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
                    }.lineLimit(1).padding(.vertical, 10).padding(.horizontal)
                }.buttonStyle(NMButton(isActive: self.showSettings))
            }.padding(22)
//        }
    }
}

struct TopPanel_Previews: PreviewProvider {
    static var previews: some View {
        TopPanel(showSettings: .constant(false))
    }
}

