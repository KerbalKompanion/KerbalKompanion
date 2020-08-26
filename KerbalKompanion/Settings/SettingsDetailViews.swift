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
            case .appearance: return AnyView(Appearence().environmentObject(self.telemachus).environmentObject(self.settings))
            case .betaFeatures: return AnyView(BetaFeatures().environmentObject(self.telemachus).environmentObject(self.settings))
            case .about: return AnyView(About().environmentObject(self.telemachus).environmentObject(self.settings))
//            default: return AnyView(Text("hi"))
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
            self.telemachus.setRate(Int(rate) ?? self.settings.rate)
            self.rate   = String(self.settings.rate)
            self.port   = String(self.settings.port)
            self.ipAdress     = self.settings.ip
        }
        
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack() {
                    HStack() {
                        VStack(alignment: .leading) {
                            Text("pref.connection.ip.label").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("pref.connection.ip.descr").font(.system(.caption, design: .monospaced)).bold()
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
                            Text("pref.connection.port.label").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("pref.connection.port.descr").font(.system(.caption, design: .monospaced)).bold()
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
                            Text("pref.connection.refreshRate.label").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("pref.connection.refreshRate.descr").font(.system(.caption, design: .monospaced)).bold()
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
                            Text("actions.save").font(.system(.subheadline, design: .monospaced)).bold()
                            Spacer()
                        }.padding().background(RoundedBackground())
                    }.buttonStyle(NMButton(isActive: false))
                        .padding([.leading, .trailing, .top], 22)
                    Spacer()
                }
            }.frame(width: 600)
            
            .onAppear {
                self.ipAdress = self.settings.ip
                self.port = String(self.settings.port)
            }
        }
    }
    
    struct Appearence: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
                        
        func saveSettings() {
        }
        
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack() {
                    Text("Coming Soon")
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text("DARK MODE").font(.system(.subheadline, design: .monospaced)).bold()
//                            Text("Choose you preference").font(.system(.caption, design: .monospaced)).bold()
//                        }
//                        Spacer()
//                        Picker(
//                            selection: $settings.darkModePreference,
//                            label: Text("Dark Mode Preference")
//                        ) {
//                            ForEach(SettingsStore.DarkModePreference.allCases, id: \.self) {
//                                Text($0.rawValue).tag($0)
//                            }
//                        }.pickerStyle(SegmentedPickerStyle()).background(RoundedBackground()).padding(15)
//                    }.padding().background(RoundedBackground()).padding([.leading, .trailing, .top], 22)
                    
                    
                    Button(action: {
                        self.saveSettings()
                    }) {
                        HStack {
                            Spacer()
                            Text("actions.save").font(.system(.subheadline, design: .monospaced)).bold()
                            Spacer()
                        }.padding().background(RoundedBackground())
                    }.buttonStyle(NMButton(isActive: false))
                        .padding([.leading, .trailing, .top], 22)
                    Spacer()
                }
            }.frame(width: 600)
        }
    }
    
    
    struct BetaFeatures: View {
        @State var toggle: Bool = false
        var loremIpsum: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
//                    FeatureItem(label: "Feature A",
//                                description: self.loremIpsum,
//                                toggle: self.$toggle)
                    Text("Coming Soon")
                }
            }
        }
        
        struct FeatureItem: View {
            var label: String
            var description: String
            @Binding var toggle: Bool
            var body: some View {
                Button(action: {
                    self.toggle.toggle()
                }) {
                    VStack {
                        HStack(alignment: .top) {
                            Image(systemName: self.toggle ? "checkmark.circle.fill" : "circle")
                                .font(.headline).frame(height: 20)
                            VStack(alignment: .leading) {
                                Text(self.label).font(.system(.subheadline, design: .monospaced)).bold().frame(height: 20)
                                Text(self.description).font(.system(.caption, design: .monospaced)).bold()
                            }
                        }
                    }.padding()
                }.accentColor(.primary).buttonStyle(NMButton()).padding()
            }
        }
    }
    
    struct About: View {
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack() {
                    HStack {
                        Image(systemName: "globe").imageScale(.large)
                        VStack(alignment: .leading) {
                            Text("pref.about.website.label").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("pref.about.website.descr").font(.system(.caption, design: .monospaced)).bold()
                        }
                        Spacer()
                        Image(systemName: "chevron.compact.right").imageScale(.large)
                    }.padding().background(RoundedBackground()).padding([.leading, .trailing, .top], 22)
                    
                    Spacer()
                }
            }.frame(width: 600)
        }
    }
    
}

