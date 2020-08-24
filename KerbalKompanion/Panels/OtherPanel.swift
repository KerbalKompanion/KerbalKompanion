//
//  OtherPanel.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct OtherPanel: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    var data: TelemachusData {
        return self.telemachus.data
    }
    var target: TelemachusData.Target? {
        return self.telemachus.data.target
    }
    
    @State var showPanelOptions: Bool = false
    
    @State var targetPane: Bool = true
    @State var envPane: Bool = true
    @State var locPane: Bool = true
    
    @State var showTargetDetail: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Button(action: {
                    withAnimation(.interactiveSpring()) {
                        self.showPanelOptions.toggle()
                    }
                } ) {
                    HStack {
                        Text("panels.other.headline")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 180)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $locPane, label: "panels.other.loc.label")
                        Divider()
                        PanelOptionButton(status: $envPane, label: "panels.other.env.label")
                        Divider()
                        PanelOptionButton(status: $targetPane, label: "panels.other.target.label")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom]).frame(width: 180)
                }
            }.background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
            
            Group() {
                VStack(alignment: .leading, spacing: 22) {

                    //MARK: Location
                    if locPane {
                        VStack() {
                            Text("panels.other.loc.label.upper").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            DataRow(label: "panels.other.loc.latitude.label", value: String(format: "%06.f", self.data.vessel.coordinates.latitude))
                            DataRow(label: "panels.other.loc.longitude.label", value: String(format: "%06.f", self.data.vessel.coordinates.longitude))
                            DataRow(label: "panels.other.loc.altitude.label", value: String(format: "%04d", Int(self.data.vessel.altitude)))
                        }.padding().background(RoundedBackground())
                    }
                    
                    //MARK: Environment
                    if envPane {
                        VStack() {
                            Text("panels.other.env.label.upper").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            DataRow(
                                label: "panels.other.env.terrainHeight.label",
                                value: String(format: "%04d", Int(self.data.environment.terrainHeight))
                            )
                            Divider()
                            DataRow(
                                label: "panels.other.env.atmDens.label",
                                value: String(format: "%04.1f", self.data.environment.atmosphericDensity)
                            )
                            Divider()
                            DataRow(
                                label: "panels.other.env.gForce.label",
                                value: String(format: "%04.2f", self.data.environment.geeforce)
                            )
                            Divider()
                        }.padding().background(RoundedBackground())
                    }
                    
                    //MARK: Target
                    if targetPane {
                        VStack(alignment: .leading) {
                            Text("panels.other.target.label.upper").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            if target != nil {
                                DataRow(label: "\'\(target!.name)\'", value: target!.type.uppercased())
                                if showTargetDetail {
                                    Divider()
                                    DataRow(label: "panels.other.target.distance.label", value: 1230)
                                    Divider()
                                    DataRow(label: "panels.other.target.velocity.label", value: String(format: "%.1f", target!.velocity))
                                    DataRow(label: "panels.other.target.relVelocity.label", value: String(format: "%.1f", target!.relativeVelocity))
                                }
                                HStack {
                                    Image(systemName: "chevron.compact.down")
                                        .rotationEffect(.degrees(self.showTargetDetail ? 180 : 0))
                                    Text("actions.showDetail")
                                }.onTapGesture {
                                    self.showTargetDetail.toggle()
                                }
                            } else {
                                DataRow(label: "panels.other.target.noTarget.label", value: "")
                            }
                        }.padding().background(RoundedBackground())
                    }
                }
            }.padding(.horizontal, 22).foregroundColor(.primary)
            Spacer()
        }.frame(width: 210)

    }
}

struct OtherPanel_Previews: PreviewProvider {
    static var previews: some View {
        OtherPanel()
    }
}
