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
                        Text("INDICATORS")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 180)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $warningLights, label: "Warnings")
                        Divider()
                        PanelOptionButton(status: $engineLights, label: "Engine")
                        Divider()
                        PanelOptionButton(status: $infoLights, label: "Infos")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom])
                }
            }.background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
            
            Group() {
                VStack(alignment: .leading, spacing: 22) {
                    //MARK: ENGINE INDICATOR LIGHTS
                    if engineLights {
                        VStack(alignment: .leading) {
                            Text("RESSOURCE STATUS").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            IndicatorView.Static(status: data.vessel.lowFuelWarning, label: "FUEL LOW", trueLight: .red, falseLight: .gray)
                            IndicatorView.Blinking(status: data.vessel.lowFuelWarning, label: "FUEL LOW", trueLight: .red, falseLight: .gray)
                            //IndicatorView(status: true, label: "ENGINE", trueLight: .yellow, falseLight: .gray)
                            }.padding().background(RoundedBackground())
                    }
                    
                    //MARK: WARNING LIGHTS
                    if warningLights {
                        VStack(alignment: .leading) {
                            Text("WARNING LIGHTS").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            IndicatorView.Blinking(status: data.vessel.lowFuelWarning, label: "FUEL LOW", trueLight: .red, falseLight: .gray)
                            IndicatorView.Blinking(status: false, label: "FLAME OUT", trueLight: .red, falseLight: .gray)
                            IndicatorView.Static(status: false, label: "TEMP HIGH", trueLight: .red, falseLight: .gray)
                            IndicatorView.Blinking(status: data.vessel.lowAltitudeWarning, label: "ALT LOW", trueLight: .red, falseLight: .gray)
                        }.padding().background(RoundedBackground())
                    }
                    
                    //MARK: INFO LIGHTS
                    if infoLights {
                        VStack(alignment: .leading) {
                            Text("INFO LIGHTS").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            IndicatorView.Static(status: data.vessel.light, label: "LIGHT", trueLight: .yellow, falseLight: .gray)
                            IndicatorView.Static(status: data.vessel.gear, label: "GEAR", trueLight: .yellow, falseLight: .gray)
                            IndicatorView.Static(status: data.vessel.brake, label: "BRAKES", trueLight: .yellow, falseLight: .gray)
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
