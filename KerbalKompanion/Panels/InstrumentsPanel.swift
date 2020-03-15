//
//  InstrumentsPanel.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct InstrumentsPanel: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var telemachus: TelemachusClient
    var data: TelemachusData {
        return self.telemachus.data
    }
    
    @State var flightDisplayPane: Bool = true
    @State var showPanelOptions: Bool = false
    var body: some View {
        VStack {
            VStack {
                Button( action: {
                    withAnimation(.interactiveSpring()) {
                        self.showPanelOptions.toggle()
                    }
                } ) {
                    HStack {
                        Text("INSTRUMENTS")
                        Image(systemName: "chevron.right.circle.fill")
                            .rotationEffect(.degrees(self.showPanelOptions ? 90 : 0))
                            .font(.system(.headline, design: .monospaced))
                    }.padding().frame(width: 250)
                }.accentColor(.primary)
                if self.showPanelOptions {
                    Divider()
                    VStack(alignment: .leading) {
                        PanelOptionButton(status: $flightDisplayPane, label: "ATTITUDE INDICATOR")
                    }.accentColor(.primary).padding([.leading, .trailing, .bottom])
                }
            }.frame(width: 250).background(RoundedBackground(isInner: self.showPanelOptions)).padding([.leading, .trailing, .bottom], 22).padding(.top, 12)
            
            Group() {
                VStack(alignment: .leading) {
                    //MARK: ENGINE INDICATOR LIGHTS
                    if flightDisplayPane {
                        AttitudeIndicator(
                            data: self.$telemachus.data,
                            frame: CGSize(width: 250, height: 250),
                            style: .small
                        )
                            .clipShape(RoundedRectangle(cornerRadius: 10)).frame(width: 250, height: 250).background(RoundedBackground())
                    }
                }
            }.padding(.horizontal, 22)
            Spacer()
        }.frame(width: 280).padding(.horizontal, 5)

    }
}

struct InstrumentsPanel_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsPanel()
    }
}
