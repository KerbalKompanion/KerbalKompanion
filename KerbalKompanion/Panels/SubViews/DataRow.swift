//
//  TargetView.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//
//
import SwiftUI
import TelemachusKit

struct DataRow: View {
    var label: LocalizedStringKey
    var value: Any?
    
    var valueString: String {
        if let value = value as? String {
            return value
        }
        if let value = value as? Double {
            return String(value)
        }
        if let value = value as? Int {
            return String(value)
        }
        return "??"
    }
    
    var body: some View {
        HStack {
            Text(self.label).font(.system(.subheadline, design: .monospaced)).bold()
            Spacer()
            Text(self.valueString).font(.system(.callout, design: .monospaced))
        }
    }
}
