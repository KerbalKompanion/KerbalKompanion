//
//  ControllToggle.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct ControllToggle: View {
    @EnvironmentObject var telemachus: TelemachusClient
    var key: TelemachusClient.Command.Key
    @Binding var state: Bool
    var label: (short: LocalizedStringKey, label: LocalizedStringKey) {
        switch self.key {
            case .brake: return (short: "controlls.toggles.toggleBrake.label.short", label: "controlls.toggles.toggleBrake.label")
            case .gear: return (short: "controlls.toggles.toggleGears.label.short", label: "controlls.toggles.toggleGears.label")
            case .light: return (short: "controlls.toggles.toggleLight.label.short", label: "controlls.toggles.toggleLight.label")
            case .rcs: return (short: "controlls.toggles.toggleRCS.label.short", label: "controlls.toggles.toggleRCS.label")
            case .sas: return (short: "controlls.toggles.toggleSAS.label.short", label: "controlls.toggles.toggleSAS.label")
            case .abort: return (short: "controlls.toggles.toggleAbort.label.short", label: "controlls.toggles.toggleAbort.label")
            default: return (short: "general.error.short", label: "general.error")
        }
    }
    
    func sendCommand() {
        var command: TelemachusClient.Command.Key = .abort
        switch self.key {
            case .brake: command = .brake
            case .gear: command = .gear
            case .light: command = .light
            case .rcs: command = .rcs
            case .sas: command = .sas
            case .abort: command = .abort
            default: command = .abort
        }
        self.telemachus.sendCommand(command)
    }
    
    var body: some View {
        Button(action: {
            self.sendCommand()
            self.state.toggle()
        }) {
            VStack {
                Text(self.label.short)
                    .font(.system(.title, design: .monospaced)).foregroundColor(.primary)
                Text(self.label.label)
                    .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
            }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).accentColor(.primary)
        }.buttonStyle(NMButton(isActive: self.state)).padding(.vertical, 15).padding(.horizontal, 20)
    }
}
