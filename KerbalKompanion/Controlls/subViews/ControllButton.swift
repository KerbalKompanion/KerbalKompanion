//
//  ActionGroupButton.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct ControllButton: View {
    @EnvironmentObject var telemachus: TelemachusClient
    var ag: TelemachusClient.Command.Key
    
    var label: (short: String, label: LocalizedStringKey) {
        switch self.ag {
            case .actionGroup01: return (short: "01", label: "controlls.actionGroup.label")
            case .actionGroup02: return (short: "02", label: "controlls.actionGroup.label")
            case .actionGroup03: return (short: "03", label: "controlls.actionGroup.label")
            case .actionGroup04: return (short: "04", label: "controlls.actionGroup.label")
            case .actionGroup05: return (short: "05", label: "controlls.actionGroup.label")
            case .actionGroup06: return (short: "06", label: "controlls.actionGroup.label")
            case .actionGroup07: return (short: "07", label: "controlls.actionGroup.label")
            case .actionGroup08: return (short: "08", label: "controlls.actionGroup.label")
            case .actionGroup09: return (short: "09", label: "controlls.actionGroup.label")
            case .actionGroup10: return (short: "10", label: "controlls.actionGroup.label")
            case .abort: return (short: "controlls.abort.label", label: "")
            
            default: return (short: "ERR", label: "ERROR")
        }
    }
    
    func sendCommand() {
        print(self.label)
    }
    
    var body: some View {
        Button(action: {
            self.sendCommand()
        }) {
            VStack {
                Text(self.label.short)
                    .font(.system(.title, design: .monospaced)).foregroundColor(.primary)
                Text(self.label.label)
                    .font(.system(.caption, design: .monospaced)).foregroundColor(.primary)
            }.lineLimit(1).padding(.vertical, 10).padding(.horizontal).accentColor(.primary)
        }.buttonStyle(NMButton()).padding(.vertical, 15).padding(.horizontal, 20)
    }
}

