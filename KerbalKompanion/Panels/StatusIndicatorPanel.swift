//
//  StatusIndicatorPanel.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit
struct StatusIndicatorPanel: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    var data: TelemachusData {
        return self.telemachus.data
    }
    
    @State var showPanelOptions: Bool = false
    
    @State var warningLights: Bool = true
    @State var engineLights: Bool = true
    @State var infoLights: Bool = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Button( action: {
                    withAnimation(.interactiveSpring()) {
                        self.showPanelOptions.toggle()
                    }
                } ) {
                    HStack {
                        Text("panels.indicators.label")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 180)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $warningLights, label: "panels.indicators.warnings.label")
                        Divider()
                        PanelOptionButton(status: $engineLights, label: "panels.indicators.engine.label")
                        Divider()
                        PanelOptionButton(status: $infoLights, label: "panels.indicators.infos.label")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom])
                }
            }.background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
            
            Group() {
                VStack(alignment: .leading, spacing: 52) {
                    
                    //MARK: WARNING LIGHTS
                    if warningLights {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("panels.indicators.warnings.label.upper").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            IndicatorView.Blinking(status: data.vessel.lowFuelWarning, label: "panels.indicators.warnings.fuelLow.label", trueLight: .red, falseLight: .gray)
                            IndicatorView.Blinking(status: false, label: "panels.indicators.warnings.flameOut.label", trueLight: .red, falseLight: .gray)
                            IndicatorView.Static(status: false, label: "panels.indicators.warnings.tempHigh.label", trueLight: .red, falseLight: .gray)
                            IndicatorView.Blinking(status: data.vessel.lowAltitudeWarning, label: "panels.indicators.warnings.altLow.label", trueLight: .red, falseLight: .gray)
                        }.padding().background(RoundedBackground())
                    }
                    
                    //MARK: ENGINE INDICATOR LIGHTS
                    if engineLights {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("panels.indicators.engine.label.upper").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            Text("Coming Soon")
                            IndicatorView.Static(status: false, label: "Coming Soon", trueLight: .yellow, falseLight: .gray)
                        }.padding().background(RoundedBackground())
                    }
                    
                    //MARK: INFO LIGHTS
                    if infoLights {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("panels.indicators.infos.label.upper").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            IndicatorView.Static(status: data.vessel.light, label: "panels.indicators.infos.light.label", trueLight: .yellow, falseLight: .gray)
                            IndicatorView.Static(status: data.vessel.gear, label: "panels.indicators.infos.gear.label", trueLight: .yellow, falseLight: .gray)
                            IndicatorView.Static(status: data.vessel.brake, label: "panels.indicators.infos.breaks.label", trueLight: .yellow, falseLight: .gray)
                        }.padding().background(RoundedBackground())
                    }
                }
            }.padding(.horizontal, 22).foregroundColor(.primary)
            Spacer()
        }.frame(width: 210)
    }
}

struct StatusIndicatorPanel_Previews: PreviewProvider {
    static var previews: some View {
        StatusIndicatorPanel()
    }
}
