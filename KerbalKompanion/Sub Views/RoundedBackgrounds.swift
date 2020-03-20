//
//  RoundedBackgrounds.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import Foundation
import SwiftUI


struct RoundedBackground: View {
    var isInner: Bool = false
    var body: some View {
        Group() {
            if !(isInner) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(CS.main_bg)
                    .shadow(color: CS.shadow_light, radius: 8, x: -5, y: -5)
                    .shadow(color: CS.shadow_dark, radius: 8, x: 5, y: 5)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(CS.main_bg, lineWidth: 4)
                    .shadow(color: CS.shadow_dark, radius: 3, x: 5, y: 5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: CS.shadow_light, radius: 3, x: -5, y: -5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
    }
}
