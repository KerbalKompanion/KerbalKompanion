//
//  ContentView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 12.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct ContentView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @State var error: AlertError?
    @State var showSheet: Bool = false
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
    var body: some View {
        TabView() {
            DataView(error: self.$error, showOnboarding: self.$showSheet)
                .environmentObject(self.telemachus)
                .environmentObject(self.settings)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Data")
                }.tag(1)
            SettingsView(error: self.$error)
                .environmentObject(self.telemachus)
                .environmentObject(self.settings)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Configuration")
                }.tag(2)
        }.onReceive(self.settings.objectWillChange) { _ in
            self.telemachus.disconnect()
        }
        .onAppear() {
            self.initTelemachus()
            self.showSheet = true
        }
        .alert(item: $error, content: { error in
            alert(title: error.title, reason: error.reason)
        })
        .sheet(isPresented: self.$showSheet) {
            OnboardingSheet()
                .environmentObject(self.telemachus)
                .environmentObject(self.settings)
        }
    }
    
    func alert(title: String, reason: String) -> Alert {
        Alert(title: Text(title),
                message: Text(reason),
                dismissButton: .default(Text("OK"))
        )
    }
    
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


