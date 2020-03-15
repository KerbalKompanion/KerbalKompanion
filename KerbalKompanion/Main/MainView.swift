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
            print("Connected")
        }
        self.telemachus.onDisconnect = { (error: Error?) in
            print("Disconnected \(error?.localizedDescription ?? "")")
            DispatchQueue.main.async {
                self.error = AlertError(title: "DISCONNECTED", reason: error?.localizedDescription ?? "")
            }
        }
    }
    
    func alert(title: String, reason: String) -> Alert {
        Alert(title: Text(title),
                message: Text(reason),
                dismissButton: .default(Text("OK"))
        )
    }
    
     var body: some View {
        VStack {
            TopPanel(showSettings: self.$showSettings).environmentObject(self.telemachus).environmentObject(self.settings)
            Group() {
                if !(self.showSettings) {
                    GeometryReader() { geo in
                        HStack {
                            MainMenu(selectedView: self.$selectedView)
                                .frame(width: 100, height: geo.size.height)
                            MainViewDetail(selectedView: self.$selectedView)
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
        case flightDisplay
        case graphs
        case grid
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct AlertError: Identifiable {
    var id: String {
        return title+reason
    }
    let title: String
    let reason: String
}

extension TelemachusData.GameStatus {
    var string: String {
        switch self {
            case .inFlight: return "IN FLIGHT"
            case .paused: return "PAUSED"
            case .noPower: return "NO POWER"
            case .disabled: return "DISABLED"
            case .notFound: return "NOT FOUND"
            case .error: return "ERROR"
        }
    }
}
