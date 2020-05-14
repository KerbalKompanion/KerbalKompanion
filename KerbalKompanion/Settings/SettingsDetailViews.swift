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
                    HStack {
                        VStack(alignment: .leading) {
                            Text("DARK MODE").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("Choose you preference").font(.system(.caption, design: .monospaced)).bold()
                        }
                        Spacer()
                        Picker(
                            selection: $settings.darkModePreference,
                            label: Text("Dark Mode Preference")
                        ) {
                            ForEach(SettingsStore.DarkModePreference.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }.pickerStyle(SegmentedPickerStyle()).background(RoundedBackground()).padding(15)
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
            }.frame(width: 600)
        }
    }
    
    
    struct BetaFeatures: View {
        var loremIpsum: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    FeatureItem(label: "Feature A", description: self.loremIpsum)
                    FeatureItem(label: "Feature B", description: self.loremIpsum)
                    FeatureItem(label: "Feature C", description: self.loremIpsum)
                    FeatureItem(label: "Feature D", description: self.loremIpsum)
                    FeatureItem(label: "Feature E", description: self.loremIpsum)
                    FeatureItem(label: "Feature F", description: self.loremIpsum)
                }
            }
        }
        
        struct FeatureItem: View {
            var label: String
            var description: String
            @State var toggle: Bool = false
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
                            Text("About the Developer").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("Website").font(.system(.caption, design: .monospaced)).bold()
                        }
                        Spacer()
                        Image(systemName: "chevron.compact.right").imageScale(.large)
                    }.padding().background(RoundedBackground()).padding([.leading, .trailing, .top], 22)
                    
                    HStack {
                        Image(systemName: "globe").imageScale(.large)
                        VStack(alignment: .leading) {
                            Text("DARK MODE").font(.system(.subheadline, design: .monospaced)).bold()
                            Text("Choose you preference").font(.system(.caption, design: .monospaced)).bold()
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

