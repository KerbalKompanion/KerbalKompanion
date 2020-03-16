//
//  SettingsView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 13.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @Binding var error: AlertError?
    @State var selectedPanel: SettingsPanel = .connection
    var body: some View {
        GeometryReader() { geometry in
            HStack {
                ScrollView() {
                    VStack() {
                        MenuItem(
                            label: "Connection",
                            icon: "antenna.radiowaves.left.and.right",
                            selectedPanel: self.$selectedPanel,
                            panel: .connection
                        )
                        
                        MenuItem(
                            label: "Appearance",
                            icon: "paintbrush",
                            selectedPanel: self.$selectedPanel,
                            panel: .appearance
                        )
                        
                        MenuItem(
                            label: "Beta Features",
                            icon: "exclamationmark.triangle.fill",
                            selectedPanel: self.$selectedPanel,
                            panel: .betaFeatures
                        )
                        
                        MenuItem(
                            label: "About",
                            icon: "person.fill",
                            selectedPanel: self.$selectedPanel,
                            panel: .about
                        )
                    }
                }.frame(width: 300)
                SettingsDetail(selectedView: self.$selectedPanel)
                    .environmentObject(self.telemachus)
                    .environmentObject(self.settings)
                    .frame(width: geometry.size.width-300, height: geometry.size.height)
            }
        }
    }
    
    enum SettingsPanel {
        case connection
        case appearance
        case betaFeatures
        case about
    }
    
    struct MenuItem: View {
        var label: String
        var icon: String
        @Binding var selectedPanel: SettingsView.SettingsPanel
        var panel: SettingsView.SettingsPanel
        
        var body: some View {
            Button(action: {
                self.selectedPanel = self.panel
            }) {
                RoundedBackground(isInner: (self.selectedPanel == self.panel))
                .overlay(
                    HStack {
                        Image(systemName: self.icon).padding()
                        Text(self.label)
                        Spacer()
                        }.font(.system(.headline, design: .monospaced)).padding(22)
                ).frame(height: 50)
            }.buttonStyle(NMButton(isActive: self.selectedPanel == self.panel))
            .accentColor(.primary)
                .padding(.horizontal, 22)
                .padding(.top, 18)
        }
    }

    
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(error: .constant(nil), selectedPanel: )
//    }
//}

