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
    private enum Keys {
        static let showOnboarding = "show_onboarding"
        static let ip = "ip_adress"
        static let port = "port_number"
        static let rate = "refresh_rate"
        static let darkModePreference = "dark_mode_preference"
        static let isAdvancedModeEnabled = "advanced_mode_enabled"
        static let isAttitudeIndicatorSchemeEnabled = "ai_scheme_enabled"
    }
    private let defaults: UserDefaults
    let objectWillChange = ObservableObjectPublisher()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.showOnboarding: true,
            Keys.ip: "0.0.0.0",
            Keys.port: 8085,
            Keys.rate: 250,
            Keys.isAdvancedModeEnabled: false,
            Keys.isAttitudeIndicatorSchemeEnabled: false
            ])
    }
    
    
    
    var ip: String {
        set {
            defaults.set(newValue, forKey: Keys.ip)
            objectWillChange.send()
        }
        get { defaults.string(forKey: Keys.ip) ?? "0.0.0.0" }
    }
    
    var port: Int {
        set {
            defaults.set(newValue, forKey: Keys.port)
            objectWillChange.send()
        }
        get { defaults.integer(forKey: Keys.port) }
    }
    
    var rate: Int {
        set {
            defaults.set(newValue, forKey: Keys.rate)
            objectWillChange.send()
        }
        get { defaults.integer(forKey: Keys.rate) }
    }
        
    var showOnboarding: Bool {
        set { defaults.set(newValue, forKey: Keys.showOnboarding) }
        get { defaults.bool(forKey: Keys.showOnboarding) }
    }
    
    var darkModePreference: DarkModePreference {
        get {
            return defaults.string(forKey: Keys.darkModePreference)
            .flatMap { DarkModePreference(rawValue: $0) } ?? .system

        }

        set {
            defaults.set(newValue.rawValue, forKey: Keys.darkModePreference)
            objectWillChange.send()
        }
    }
    
    var beta_isAdvancedModeEnabled: Bool {
        get {
            return defaults.bool(forKey: Keys.isAdvancedModeEnabled)
        }
        
        set {
            defaults.set(newValue, forKey: Keys.isAdvancedModeEnabled)
            objectWillChange.send()
        }
    }
    
    var beta_isAttitudeIndicatorSchemeEnabled: Bool {
        get {
            return defaults.bool(forKey: Keys.isAttitudeIndicatorSchemeEnabled)
        }
        
        set {
            defaults.set(newValue, forKey: Keys.isAttitudeIndicatorSchemeEnabled)
            objectWillChange.send()
        }
    }
    
    enum DarkModePreference: String, CaseIterable {
        case dark
        case light
        case system
    }

}
