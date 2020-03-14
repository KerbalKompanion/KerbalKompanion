//
//  SettingsStore.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 13.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class SettingsStore: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var ip: String = "192.168.178.23" {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var port: String = "8085" {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        
    }
}
