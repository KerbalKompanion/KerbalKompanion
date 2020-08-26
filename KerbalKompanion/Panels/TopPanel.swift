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
    @Binding var error: AlertError?
    var data: TelemachusData {
        return self.telemachus.data
    }
    @State var showHeightFromTerrain: Bool = true
    
    var gameStatus: (label: LocalizedStringKey, icon: String, color: Color) {
        switch self.data.gameStatus {
        case .inFlight:  return (label: self.data.gameStatus.string, icon: "dot.radiowaves.left.and.right", color: .primary)
        case .noVessel:  return (label: self.data.gameStatus.string, icon: "dot.radiowaves.left.and.right", color: .yellow)
        case .paused:    return (label: self.data.gameStatus.string, icon: "pause.fill", color: .yellow)
        case .noPower:   return (label: self.data.gameStatus.string, icon: "bolt.slash.fill", color: .red)
        case .disabled:  return (label: self.data.gameStatus.string, icon: "wifi.slash", color: .yellow)
        case .notFound:  return (label: self.data.gameStatus.string, icon: "questionmark", color: .yellow)
        case .error:     return (label: self.data.gameStatus.string, icon: "exclamationmark.triangle.fill", color: .red)
        }
    }
    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 25) {
                //MARK: CONNECTION STATUS
                Button(action: {
                    self.telemachus.connect(self.settings.ip, self.settings.port) { result in
                        switch result {
                            case .success:
                                self.telemachus.setRate(self.settings.rate)
                                self.telemachus.subscribeTo(TelemachusClient.ApiKey.allCases)
                            case .failure: break //self.error = AlertError(title: "ERROR", reason: "Could not connect to Server")
                        }
                    }
                }) {
                    VStack {
                        Text(" ").overlay(
                            Image(systemName: self.gameStatus.icon)
                        )
                        .font(.largeTitle)
                            .accentColor(self.telemachus.isConnected ? self.gameStatus.color : .red)
                            
                        Text(self.telemachus.isConnected ? self.gameStatus.label : LocalizedStringKey("connStat.disconnected"))
                            .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
                    }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                }.buttonStyle(NMButton()).accentColor(.primary)
                
                //MARK: ALTITUDE INDICATOR
                Button(action: {
                    self.showHeightFromTerrain.toggle()
                }) {
                    VStack {
                        Text(String(format: "%05d", Int(self.showHeightFromTerrain ? data.vessel.heightFromTerrain : data.vessel.altitude))+" m" )
                            .font(.system(.largeTitle, design: .monospaced))
                            .accentColor(.primary)
                        Text(self.showHeightFromTerrain ? "toppanel.heightFromTerrain.label" : "toppanel.altitude.label")
                            .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
                    }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                }.buttonStyle(NMButton()).accentColor(.primary)
                
                //MARK: VERTICAL SPEEDOMETER
                VStack {
                    Text((Int(data.vessel.speed.vertical) < 0 ? "-" : "+") + String(format: "%04d", abs(Int(data.vessel.speed.vertical))))
                        .font(.system(.largeTitle, design: .monospaced))
                    Text("toppanel.vertSpeed.label").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical,10).padding(.horizontal).background(RoundedBackground())
                
                //MARK: VELOCITY INDICATOR
                VStack {
                    Text(String(format: "%04d", Int(data.vessel.speed.surface)))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(.primary)
                    Text("toppanel.surfSpeed.label").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                
                //MARK: HEADING INDICATOR
                VStack {
                    Text(String(format: "%03d", Int(data.vessel.attitude.heading)))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(.primary)
                    Text("toppanel.heading.label").font(.system(.caption, design: .monospaced))
                }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).background(RoundedBackground())
                                
                //MARK: PITCH INDICATOR
                VStack {
                    Text(String(format: "%03d", Int(data.vessel.attitude.pitch)))
                        .font(.system(.largeTitle, design: .monospaced))
                        .accentColor(.primary)
                    Text("toppanel.pitch.label").font(.system(.caption, design: .monospaced))
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
                            
                        Text("toppanel.prefButton.label")
                            .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
                    }.lineLimit(1).padding(.vertical, 10).padding(.horizontal)
                }.buttonStyle(NMButton(isActive: self.showSettings))
            }.padding(22).foregroundColor(.primary)
//        }
    }
}

struct TopPanel_Previews: PreviewProvider {
    static var previews: some View {
        TopPanel(showSettings: .constant(false), error: .constant(nil))
    }
}

