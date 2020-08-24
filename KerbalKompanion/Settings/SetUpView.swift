//
//  SetUpView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.05.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct SetUpView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    @Binding var error: AlertError?
    
    @State var ipAddress: String = ""
    @State var port: String = ""
    @State var rate: String = ""
    
    func testConnection() {
        print(self.ipAddress, self.port, self.rate)
        self.settings.ip    = self.ipAddress
        self.settings.port  = Int(port) ?? self.settings.port
        self.settings.rate  = Int(rate) ?? self.settings.rate
        self.rate   = String(self.settings.rate)
        self.port   = String(self.settings.port)
        self.ipAddress     = self.settings.ip
        
        self.telemachus.connect(self.settings.ip, self.settings.port) { result in
            switch result {
                case .success:
                    self.telemachus.setRate(self.settings.rate)
                    self.telemachus.subscribeTo(TelemachusClient.ApiKey.allCases)
                case .failure:
                    self.error = AlertError(title: "ERROR", reason: "Could not connect to Server")
            }
        }
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
                    TextField("255.255.255.255", text: self.$ipAddress)
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
                    self.testConnection()
                }) {
                    HStack {
                        Spacer()
                        Text("CONNECT").font(.system(.subheadline, design: .monospaced)).bold()
                        Spacer()
                    }.padding().background(RoundedBackground())
                }.buttonStyle(NMButton(isActive: false))
                    .padding([.leading, .trailing, .top], 22)
                Spacer()
            }
        }.frame(width: 600)
        
        .onAppear {
            self.ipAddress = self.settings.ip
            self.port = String(self.settings.port)
        }
    }
}

struct SetUpView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpView(error: .constant(nil))
    }
}
