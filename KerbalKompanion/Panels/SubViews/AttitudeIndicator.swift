//
//  AttitudeIndicator.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit
import PrimaryFlightDisplay
import SpriteKit

struct AttitudeIndicator: UIViewRepresentable {
    @Binding var data: TelemachusData
    var frame: CGSize
    var style: Style
    
    var config: PrimaryFlightDisplay.SettingsType {
        switch style {
        case .small:
            var config = PrimaryFlightDisplay.DefaultSmallScreenSettings()
            config.airSpeedIndicator.size.width = 0
            config.altimeter.size.width = 0
            config.headingIndicator.size.height = 10
            
            config.horizon.groundColor = SKColor.brown
            config.horizon.skyColor = SKColor.blue
            config.horizon.zeroPitchLineColor = SKColor.purple
            return config
        }
    }
    func makeUIView(context: Context) -> PrimaryFlightDisplayView {
        let flightView = PrimaryFlightDisplayView(frame: .zero, settings: self.config)
        flightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return flightView
    }

    func updateUIView(_ view: PrimaryFlightDisplayView, context: Context) {
        view.setAttitude(rollRadians: self.data.vessel.attitude.roll, pitchRadians: self.data.vessel.attitude.pitch)
        view.setHeadingDegree(self.data.vessel.attitude.heading)
        view.setAirSpeed(self.data.vessel.speed.surface)
        view.setAltitude(self.data.vessel.altitude)
    }
    
    enum Style {
        case small
    }
}
