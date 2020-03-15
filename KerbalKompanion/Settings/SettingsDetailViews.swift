//
//  SettingsDetail.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct SettingsDetail: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @Binding var selectedView: SettingsView.SettingsPanel
    
    var body: some View {
        containedView()
    }

    func containedView() -> AnyView {
        switch selectedView {
            case .connection: return AnyView(Connection().environmentObject(self.telemachus).environmentObject(self.settings))
            default: return AnyView(Text("hi"))
        }
    }
    
    struct Connection: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
                
        @State var ipAdress: String = ""
        @State var port: String = ""
        @State var rate: String = ""
        
        func saveSettings() {
            self.settings.ip    = self.ipAdress
            self.settings.port  = Int(port) ?? self.settings.port
            self.settings.rate  = Int(rate) ?? self.settings.rate
        }
        
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack() {
                    HStack() {
                        VStack(alignment: .leading) {
                            Text("IP ADRESS").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("The adress of the pc running KSP").font(.system(.caption, design: .monospaced)).bold()
                        }
                        Spacer()
                        TextField("255.255.255.255", text: self.$ipAdress)
                            .font(.system(.callout, design: .monospaced))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(CS.shadow_dark))
                            .frame(width: 200)
                    }.padding().background(RoundedBackground()).padding([.leading, .trailing, .top], 22)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("PORT NUMBER").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("Standard is 8085").font(.system(.caption, design: .monospaced)).bold()
                        }
                        Spacer()
                        TextField("8085", text: self.$port).keyboardType(.numberPad)
                            .font(.system(.callout, design: .monospaced))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(CS.shadow_dark))
                            .frame(width: 200)
                    }.padding().background(RoundedBackground()).padding([.leading, .trailing, .top], 22)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("REFRESH RATE").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("Rate at which data is transmitted").font(.system(.caption, design: .monospaced)).bold()
                        }
                        Spacer()
                        TextField("500", text: self.$rate).keyboardType(.numberPad)
                            .font(.system(.callout, design: .monospaced))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(CS.shadow_dark))
                            .frame(width: 200)
                    }.padding().background(RoundedBackground()).padding([.leading, .trailing, .top], 22)
                    
                    Button(action: {
                        self.saveSettings()
                    }) {
                        HStack {
                            Spacer()
                            Text("SAVE").font(.system(.subheadline, design: .monospaced)).bold()
                            Spacer()
                        }.padding().background(RoundedBackground())
                    }.buttonStyle(NMButton(isActive: false))
                        .padding([.leading, .trailing, .top], 22)
                    Spacer()
                }
            }.frame(width: 500)
            
            .onAppear {
                self.ipAdress = self.settings.ip
                self.port = String(self.settings.port)
            }
        }
    }
    
    
}

