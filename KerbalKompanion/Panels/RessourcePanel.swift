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
                        Text("panels.ressources.label")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 200)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $ressourceOverview, label: "panels.ressources.overview.label")
                        Divider()
                        PanelOptionButton(status: $liquidGauge, label: "panels.ressources.liquid.label")
                        Divider()
                        PanelOptionButton(status: $ecGauge, label: "panels.ressources.electric.label")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom])
                }
            }.background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
                        
            Group() {
                VStack(alignment: .leading, spacing: 22) {
                    //MARK: ENGINE INDICATOR LIGHTS
                    //MARK: OVERVIEW
                    if ressourceOverview {
                        VStack(alignment: .leading) {
                            RessourceView.Graph(label: "panels.ressources.liquid.label.short", fuel: self.data.vessel.ressource.liquid)
                            RessourceView.Graph(label: "panels.ressources.electric.label.short", fuel: self.data.vessel.ressource.electricCharge)
                            RessourceView.Graph(label: "panels.ressources.intakeAir.label.short", fuel: self.data.vessel.ressource.intakeAir)
                        }.padding().background(RoundedBackground())
                    }

                    //MARK: LIQUID GAUGE
                    if liquidGauge {
                        RessourceView.Detail(
                            label: "panels.ressources.liquid.label.long",
                            fuel: self.data.vessel.ressource.liquid
                        ).environmentObject(self.telemachus)
                    }

                    //MARK: EC Gauge
                    if ecGauge {
                        RessourceView.Detail(
                            label: "panels.ressources.electric.label.long",
                            fuel: self.data.vessel.ressource.electricCharge
                        ).environmentObject(self.telemachus)
                    }
                    
                    //MARK: INTAKE GAUGE
//                    if intakeGauge {
//                    }
                }
            }.padding(.horizontal, 22).foregroundColor(.primary)
            Spacer()
        }.frame(width: 230)
    }
}

