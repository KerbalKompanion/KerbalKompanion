//
//  GridItem.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit

struct GridItem: View {
    @EnvironmentObject var telemachus: TelemachusClient
    var body: some View {
        RoundedBackground()
    }
}

struct GridItem_Previews: PreviewProvider {
    static var previews: some View {
        GridItem()
    }
}
