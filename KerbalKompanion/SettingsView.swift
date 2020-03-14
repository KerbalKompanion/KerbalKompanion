//
//  SettingsView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 13.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @Binding var error: AlertError?
    
    var body: some View {
        NavigationView {
            Form() {
                Section(header: Text("Connection Settings")) {
                    NavigationLink(destination:
                        TextField("IP ADRESS", text: self.$settings.ip)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    ) {
                        HStack {
                            Text("IP:")
                            Spacer()
                            Text(self.settings.ip)
                        }
                    }
                    NavigationLink(destination:
                        TextField("PORT NUMBER", text: self.$settings.port)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    ) {
                        HStack {
                            Text("PORT:")
                            Spacer()
                            Text(String(self.settings.port))
                        }
                    }
                }
                
                Section(header: Text("Connected URL")) {
                    HStack {
                        Text("Scheme")
                        Spacer()
                        Text("\(self.telemachus.currentURL?.scheme ?? "Not Connected")")
                    }
                    HStack {
                        Text("Host")
                        Spacer()
                        Text("\(self.telemachus.currentURL?.host ?? "Not Connected")")
                    }
                    HStack {
                        Text("Port")
                        Spacer()
                        Text(String(self.telemachus.currentURL?.port ?? 0))
                    }
                }
            }
            .navigationBarTitle("Settings")
            .onReceive(self.settings.objectWillChange) { _ in
                self.telemachus.disconnect()
            }
        }
    }
    
    var numberFormatter: Formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        formatter.allowsFloats = false
        return formatter
    }()
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(error: .constant(nil))
    }
}

