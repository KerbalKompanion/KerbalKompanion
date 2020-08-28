//
//  InstrumentsPanel.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct InstrumentsPanel: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    var data: TelemachusData {
        return self.telemachus.data
    }
    
    @State var flightDisplayPane: Bool = true
    @State var envPane: Bool = true
    @State var showPanelOptions: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Button( action: {
                    withAnimation(.interactiveSpring()) {
                        self.showPanelOptions.toggle()
                    }
                } ) {
                    HStack {
                        Text("panels.instruments.headline")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 250)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $flightDisplayPane, label: "panels.instruments.attInd.label")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom])
                }
            }.frame(width: 250).background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
            
            Group() {
                VStack(alignment: .leading, spacing: 22) {
                    //MARK: ENGINE INDICATOR LIGHTS
                    if flightDisplayPane {
                        VStack {
                            AttitudeIndicator(
                                data: self.$telemachus.data,
                                frame: CGSize(width: 250, height: 250),
                                style: .small
                            )
                            .environmentObject(self.settings)
                            .clipShape(Circle())
                            .frame(width: 220, height: 220)
                            Gauge(label: "panels.instruments.gForce.label", value: self.data.environment.geeforce, max: 15, error: 0.6)
                        }.padding().frame(width: 250).background(RoundedBackground())
                            
                            
                    }
                    
//                    if envPane {
//                        VStack() {
//                            Gauge(label: "G-Force", value: self.data.environment.geeforce, max: 15, error: 0.6)
//                            Gauge(label: "G-Force", value: self.data.environment.geeforce, max: 15, error: 0.6)
//                            Gauge(label: "G-Force", value: self.data.environment.geeforce, max: 15, error: 0.6)
//                        }.padding().background(RoundedBackground())
//                    }
                }
            }.padding(.horizontal, 22)
            Spacer()
        }.frame(width: 280).padding(.horizontal, 5).foregroundColor(.primary)

    }
}

struct InstrumentsPanel_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsPanel()
    }
}
