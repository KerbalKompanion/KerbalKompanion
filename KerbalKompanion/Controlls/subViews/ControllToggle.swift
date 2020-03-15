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
    var label: (short: String, label: String) {
        switch self.key {
            case .brake: return (short: "BRAKE", label: "TOGGLE BRAKE")
            case .gear: return (short: "GEARS", label: "TOGGLE GEARS")
            case .light: return (short: "LIGHT", label: "TOGGLE LIGHT")
            case .rcs: return (short: " RCS ", label: " TOGGLE RCS ")
            case .sas: return (short: " SAS ", label: " TOGGLE SAS ")
            case .abort: return (short: "ABORT", label: "TOGGLE ABORT")
            default: return (short: "ERR", label: "ERROR")
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
