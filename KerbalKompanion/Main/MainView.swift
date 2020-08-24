//
//  DataView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 13.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct MainView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    
    @State var selectedView: MainView = .panels
    @State var showSettings: Bool = false
    @State var error: AlertError?
    
    func initTelemachus() {
        self.telemachus.onConnect = {
            
        }
//        self.telemachus.onDisconnect = { (error: Error?) in
//            DispatchQueue.main.async {
//                self.error = AlertError(title: "DISCONNECTED", reason: error?.localizedDescription ?? "")
//            }
//        }
    }
    
    func alert(title: LocalizedStringKey, reason: LocalizedStringKey) -> Alert {
        Alert(title: Text(title),
                message: Text(reason),
                dismissButton: .default(Text("OK"))
        )
    }
    
     var body: some View {
        VStack {
            TopPanel(showSettings: self.$showSettings, error: self.$error).environmentObject(self.telemachus).environmentObject(self.settings)
            Group() {
                if !(self.showSettings) {
                    GeometryReader() { geo in
                        HStack {
                            MainMenu(selectedView: self.$selectedView)
                                .frame(width: 100, height: geo.size.height)
                            MainViewDetail(selectedView: self.$selectedView, error: self.$error)
                                .frame(width: geo.size.width-100, height: geo.size.height)
                        }
                    }
                } else {
                    SettingsView(error: self.$error)
                }
            }
            Spacer()
        }
        .onAppear() {
            self.initTelemachus()
        }
        .alert(item: $error, content: { error in
            alert(title: error.title, reason: error.reason)
        })
        .background(CS.main_bg.edgesIgnoringSafeArea(.all))
    }
    
    
    enum MainView {
        case panels
        case controll
        case flightDisplay
        case map
        case grid
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct AlertError: Identifiable {
    let id = UUID().uuidString
    let title: LocalizedStringKey
    let reason: LocalizedStringKey
}

extension TelemachusData.GameStatus {
    var string: LocalizedStringKey {
        switch self {
            case .inFlight: return LocalizedStringKey("gameStatus.inFlight")
            case .noVessel: return LocalizedStringKey("gameStatus.noVessel")
            case .paused: return LocalizedStringKey("gameStatus.paused")
            case .noPower: return LocalizedStringKey("gameStatus.noPower")
            case .disabled: return LocalizedStringKey("gameStatus.disabled")
            case .notFound: return LocalizedStringKey("gameStatus.notFound")
            case .error: return LocalizedStringKey("gameStatus.error")
        }
    }
}
