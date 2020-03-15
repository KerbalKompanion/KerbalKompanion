//
//  ToggleControll.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct ToggleControll: View {
    @EnvironmentObject var telemachus: TelemachusClient
    var data: TelemachusData {
        return self.telemachus.data
    }
    var body: some View {
        VStack(alignment: .center) {
            Text("Vessel System Toggles").font(.system(.title, design: .monospaced))
            HStack {
                Spacer()
                VStack {
                    HStack(spacing: 0) {
                        ControllToggle(
                            key: .rcs,
                            state: self.$telemachus.data.vessel.rcs
                        )
                        ControllToggle(
                            key: .sas,
                            state: self.$telemachus.data.vessel.sas
                        )
                        ControllToggle(
                            key: .light,
                            state: self.$telemachus.data.vessel.light
                        )
                        ControllToggle(
                            key: .gear,
                            state: self.$telemachus.data.vessel.gear
                        )
                        ControllToggle(
                            key: .brake,
                            state: self.$telemachus.data.vessel.brake
                        )
                    }
                }
                Spacer()
            }
        }
        
        .padding()
        .background(RoundedBackground(isInner: true))
    }
}

struct ToggleControll_Previews: PreviewProvider {
    static var previews: some View {
        ToggleControll()
    }
}
