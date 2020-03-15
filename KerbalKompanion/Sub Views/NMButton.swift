//
//  NMButton.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import Foundation
import SwiftUI

struct NMButton: ButtonStyle {
    var isActive: Bool = false
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(RoundedBackground(isInner: configuration.isPressed || self.isActive))
    }
}
