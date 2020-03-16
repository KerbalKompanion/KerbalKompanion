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
    @State var sensorPane: Bool = true
    
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
                        Text("OTHER")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 180)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
//                        PanelOptionButton(status: $sensorPane, label: "Sensors")
                        PanelOptionButton(status: $targetPane, label: "Something Else")
                        Divider()
                        PanelOptionButton(status: $targetPane, label: "Target")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom]).frame(width: 180)
                }
            }.background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
            
            Group() {
                VStack(alignment: .leading, spacing: 22) {
                    //MARK: ENGINE INDICATOR LIGHTS
                    
                    if sensorPane {
                        VStack(alignment: .leading) {
                            Text("SENSOR DATA").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            if self.data.sensors.availableSensors.count > 0 {
                                if self.data.sensors.availableSensors.contains(.temperature) {
                                    DataRow(label: "TEMPERATURE", value: self.data.sensors.temperature)
                                    Divider()
                                }
                                if self.data.sensors.availableSensors.contains(.pressure) {
                                    DataRow(label: "PRESSURE", value: self.data.sensors.pressure)
                                    Divider()
                                }
                                if self.data.sensors.availableSensors.contains(.acceleration) {
                                    DataRow(label: "ACCELERATION", value: self.data.sensors.acceleration)
                                    Divider()
                                }
                                if self.data.sensors.availableSensors.contains(.gravitation) {
                                    DataRow(label: "GRAVITATION", value: self.data.sensors.gravitation)
                                    Divider()
                                }
                            } else {
                                DataRow(label: "NO SENSORS ON BOARD", value: "")
                            }
                            
                            
                        }.padding().background(RoundedBackground())
                    }
                    
                    if targetPane {
                        VStack(alignment: .leading) {
                            Text("TARGET INFO").font(.system(.subheadline, design: .monospaced)).bold()
                            Divider()
                            if target != nil {
                                DataRow(label: "\'\(target!.name)\'", value: target!.type.uppercased())
                                if showTargetDetail {
                                    Divider()
                                    DataRow(label: "DISTANCE", value: 1230)
                                    Divider()
                                    DataRow(label: "VELOCITY", value: String(format: "%.1f", target!.velocity))
                                    DataRow(label: "REL. VELOCITY", value: String(format: "%.1f", target!.relativeVelocity))
                                }
                                HStack {
                                    Image(systemName: "chevron.compact.down")
                                        .rotationEffect(.degrees(self.showTargetDetail ? 180 : 0))
                                    Text("DETAIL")
                                }.onTapGesture {
                                    self.showTargetDetail.toggle()
                                }
                            } else {
                                DataRow(label: "\t", value: "NO TARGET")
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
