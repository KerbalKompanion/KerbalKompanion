//
//  OnboardingView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 13.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct OnboardingSheet: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    var body: some View {
        VStack {
            Text("1. Enter IP and Port")
            TextField("IP ADRESS", text: self.$settings.ip)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(self.telemachus.isConnected)
            TextField("PORT NUMBER", text: self.$settings.port)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(self.telemachus.isConnected)
            Spacer()
            Text("2. Connect")
            Button(action: {
                if self.telemachus.isConnected {
                    self.telemachus.disconnect()
                } else {
                    self.telemachus.connect(self.settings.ip, Int(self.settings.port)!)
                }
            }) {
                Text(self.telemachus.isConnected ? "Disconnect" : "Connect")
            }
            Spacer()
            Text("3. Subscribe to Data")
            Button(action: {
                self.telemachus.subscribeTo(TelemachusClient.ApiKey.allCases)
            }) {
                Text("Subscribe")
            }.disabled(!(self.telemachus.isConnected))
            Spacer()
        }
    }
}
