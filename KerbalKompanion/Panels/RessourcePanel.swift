//
//  RessourcePanel.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct RessourcePanel: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    var data: TelemachusData {
        return self.telemachus.data
    }
    
    @State var showPanelOptions: Bool = false
    
    @State var ressourceOverview: Bool = true
    @State var liquidGauge: Bool = true
    @State var ecGauge: Bool = true
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Button(action: {
                    withAnimation(.interactiveSpring()) {
                        self.showPanelOptions.toggle()
                    }
                } ) {
                    HStack {
                        Text("RESSOURCE")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 200)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $ressourceOverview, label: "Overview")
                        Divider()
                        PanelOptionButton(status: $liquidGauge, label: "Liquid")
                        Divider()
                        PanelOptionButton(status: $ecGauge, label: "Energy")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom])
                }
            }.background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
                        
            Group() {
                VStack(alignment: .leading, spacing: 22) {
                    //MARK: ENGINE INDICATOR LIGHTS
                    //MARK: OVERVIEW
                    if ressourceOverview {
                        VStack(alignment: .leading) {
                            RessourceView.Graph(label: "LQD", fuel: self.data.vessel.ressource.liquid)
                            RessourceView.Graph(label: "LQD", fuel: self.data.vessel.ressource.liquid)
                            RessourceView.Graph(label: "LQD", fuel: self.data.vessel.ressource.liquid)
                        }.padding().background(RoundedBackground())
                    }

                    //MARK: LIQUID GAUGE
                    if liquidGauge {
                    }

                    //MARK: EC Gauge
                    if ecGauge {
                    }
                }
            }.padding(.horizontal, 22)
            Spacer()
        }.frame(width: 230)
    }
}

