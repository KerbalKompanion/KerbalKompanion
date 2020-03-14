//
//  DataView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 13.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct DataView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    
    @Binding var error: AlertError?
    @Binding var showOnboarding: Bool
     var body: some View {
        NavigationView {
            List() {
                Section(header: Text("General Information")) {
                    InfoRowStatus(title: "Game Status", value: self.$telemachus.data.gameStatus)
//                    InfoRowDate(title: "Universal Time", value: self.$telemachus.data.universalTime)
//                    InfoRowDate(title: "Mission Time", value: self.$telemachus.data.missionTime)
                    InfoRowString(title: "Vessel Name", value: self.$telemachus.data.vessel.name)
                }
                Section(header: Text("Vessel Position")) {
                    InfoRowDouble(title: "Altitude", value: self.$telemachus.data.vessel.altitude)
                    InfoRowDouble(title: "Height From Terrain", value: self.$telemachus.data.vessel.heightFromTerrain)
                    InfoRowDouble(title: "Surface Speed", value: self.$telemachus.data.vessel.speed.surface)
                    InfoRowDouble(title: "Vertical Speed", value: self.$telemachus.data.vessel.speed.vertical)
                }
                
                Section(header: Text("Vessel Attitude")) {
                    InfoRowDouble(title: "Roll", value: self.$telemachus.data.vessel.attitude.roll)
                    InfoRowDouble(title: "Pitch", value: self.$telemachus.data.vessel.attitude.pitch)
                    InfoRowDouble(title: "Heading", value: self.$telemachus.data.vessel.attitude.heading)
                }
                
                Section(header: Text("Toggles")) {
                    InfoRowBool(title: "Gear", value: self.$telemachus.data.vessel.gear)
                    InfoRowBool(title: "Brake", value: self.$telemachus.data.vessel.brake)
                    InfoRowBool(title: "Light", value: self.$telemachus.data.vessel.light)
                }
            }
            
            .navigationBarTitle("Telemachus Data")
            .navigationBarItems(
                leading:
                    Button(action: {
                        if self.telemachus.isConnected {
                            self.telemachus.disconnect()
                        } else {
                            self.telemachus.connect(self.settings.ip, Int(self.settings.port)!) {
                                self.telemachus.subscribeTo(TelemachusClient.ApiKey.allCases)
                            }
                        }
                    }) {
                        Image(systemName: self.telemachus.isConnected ? "wifi" : "wifi.slash")
                            .foregroundColor(self.telemachus.isConnected ? .green : .red)
                    }
                ,trailing:
                    Button(action: {
                        self.telemachus.disconnect()
                        self.showOnboarding = true
                    }) {
                        Text("Reconnect")
                    }
            )
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(error: .constant(nil), showOnboarding: .constant(false))
    }
}

struct AlertError: Identifiable {
    var id: String {
        return title+reason
    }
    let title: String
    let reason: String
}

struct InfoRowStatus: View {
    var title: String
    @Binding var value: TelemachusData.GameStatus
    var body: some View {
        HStack {
            Text(self.title)
            Spacer()
            Text(self.value.string)
        }
    }
}

struct InfoRowDate: View {
    var title: String
    @Binding var value: Date
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd-MM-yyyy"
        return formatter
    }
    var body: some View {
        HStack {
            Text(self.title)
            Spacer()
            Text("self.formatter.string(from: self.value)")
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct InfoRowString: View {
    var title: String
    @Binding var value: String
    var body: some View {
        HStack {
            Text(self.title)
            Spacer()
            Text(self.value)
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct InfoRowDouble: View {
    var title: String
    @Binding var value: Double
    var body: some View {
        HStack {
            Text(self.title)
            Spacer()
            Text(String(format: "%07.2f", Double(self.value)))
//                .font(.system(.body, design: .monospaced))
        }
    }
}

struct InfoRowBool: View {
    var title: String
    @Binding var value: Bool
    var body: some View {
        HStack {
            Text(self.title)
            Spacer()
            Text(self.value ? "TRUE" : "FALSE")
                .font(.system(.body, design: .monospaced))
            Image(systemName: "circle.fill")
                .foregroundColor(self.value ? .green : .red)
                .font(.system(.body, design: .monospaced))
        }
    }
}
