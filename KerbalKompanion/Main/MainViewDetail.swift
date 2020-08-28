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
    @Binding var error: AlertError?

    
    var body: some View {
        if self.telemachus.isConnected {
            return containedView()
        } else {
            return AnyView(
                SetUpView(error: self.$error)
                    .environmentObject(self.settings)
                    .environmentObject(self.telemachus)
            )
                
        }
    }

    func containedView() -> AnyView {
        switch selectedView {
            case .panels:        return AnyView(PanelView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .controll:      return AnyView(ControllView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .flightDisplay: return AnyView(FlightDisplayView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .map:           return AnyView(RoundedBackground(isInner: true).overlay(Text("Coming Soon")).padding())
            //return AnyView(MapView().environmentObject(self.telemachus).environmentObject(self.settings))
            case .grid:          return AnyView(RoundedBackground(isInner: true).overlay(Text("Coming Soon")).padding())
            //return AnyView(GridView().environmentObject(self.telemachus).environmentObject(self.settings))
        }
    }
    
    //MARK: PanelView
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
    
    //MARK: ControllView
    struct ControllView: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
        
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack() {
                    ActionGroupControll().environmentObject(self.telemachus)
                    Spacer().frame(height: 20)
                    ToggleControll().environmentObject(self.telemachus)
                }
                .padding()
            }
        }
    }
    
    //MARK: FlightDisplayView
    struct FlightDisplayView: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
                        
        var body: some View {
            AttitudeIndicator(
                data: self.$telemachus.data,
                frame: CGSize(width: 500, height: 500),
                style: .fullScreen
            )
            .environmentObject(self.settings)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(RoundedBackground())
            .padding(.trailing)
        }
    }
    
    //MARK: MapView
    struct MapView: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
        var body: some View {
            RoundedBackground()
        }
    }
    
    //MARK: GridView
    struct GridView: View {
        @EnvironmentObject var settings: SettingsStore
        @EnvironmentObject var telemachus: TelemachusClient
                
        @State var isShowingMenu: Bool = false
        func size(_ geo: GeometryProxy) -> CGSize {
            let width = (geo.size.width / 2) - 44
            let height = (geo.size.height / 2) - 44
            if isShowingMenu {
                return CGSize(width: width - 220, height: height - 220)
            } else {
                return CGSize(width: width, height: height)
            }
            
        }
        
        var body: some View {
            GeometryReader() { geo in
                VStack(spacing: 30) {
                    HStack(spacing: 30) {
                        GridItem()
                            .environmentObject(self.telemachus)
                            .frame(width: self.size(geo).width, height: self.size(geo).height)
                        GridItem()
                            .environmentObject(self.telemachus)
                            .frame(width: self.size(geo).width, height: self.size(geo).height)
                    }
                    HStack(spacing: 30) {
                        GridItem()
                            .environmentObject(self.telemachus)
                            .frame(width: self.size(geo).width, height: self.size(geo).height)
                        GridItem()
                            .environmentObject(self.telemachus)
                            .frame(width: self.size(geo).width, height: self.size(geo).height)
                    }
//                    if self.isShowingMenu {
//                        
//                    }
                }.padding(12)
            }
        }
        
        enum GridOption {
            case altitudeGraph
            case environment
            case map
        }
    }
    
}
