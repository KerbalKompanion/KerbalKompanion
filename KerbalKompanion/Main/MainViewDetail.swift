//
//  MainViewDetail.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct MainViewDetail: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @Binding var selectedView: MainView.MainView
    
    var body: some View {
        containedView()
    }

    func containedView() -> AnyView {
        switch selectedView {
            case .panels:        return AnyView(PanelView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .flightDisplay: return AnyView(FlightDisplayView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .graphs:        return AnyView(GraphView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .grid:          return AnyView(GridView().environmentObject(self.telemachus).environmentObject(self.settings))
            default: return AnyView(Text("hi"))
        }
    }
    
    struct PanelView: View {
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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    InstrumentsPanel().environmentObject(self.telemachus).environmentObject(self.settings)
                    OtherPanel().environmentObject(self.telemachus).environmentObject(self.settings)
                    RessourcePanel().environmentObject(self.telemachus).environmentObject(self.settings)
                    StatusIndicatorPanel().environmentObject(self.telemachus).environmentObject(self.settings)
                }
            }
        }
    }
    
    struct FlightDisplayView: View {
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
            RoundedBackground()
        }
    }
    
    struct GraphView: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
                        
        var body: some View {
            RoundedBackground()
        }
    }
    
    struct GridView: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
                
        func size(_ geo: GeometryProxy) -> CGSize {
            let width = (geo.size.width / 2) - 44
            let height = (geo.size.height / 2) - 44
            return CGSize(width: width, height: height)
        }
        
        var body: some View {
            GeometryReader() { geo in
                VStack(spacing: 30) {
                    HStack(spacing: 30) {
                        RoundedBackground().frame(width: self.size(geo).width, height: self.size(geo).height)
                        RoundedBackground().frame(width: self.size(geo).width, height: self.size(geo).height)
                    }
                    HStack(spacing: 30) {
                        RoundedBackground().frame(width: self.size(geo).width, height: self.size(geo).height)
                        RoundedBackground().frame(width: self.size(geo).width, height: self.size(geo).height)
                    }
                }.padding(12)
            }
        }
    }
    
}
