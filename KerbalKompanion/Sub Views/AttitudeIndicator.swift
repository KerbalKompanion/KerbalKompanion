//
//  AttitudeIndicator.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 14.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI
import TelemachusKit
import SpriteKit
import PrimaryFlightDisplay


struct AttitudeIndicator: UIViewRepresentable {
    @Binding var data: TelemachusData
    var frame: CGSize
    var style: Style
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    var config: PrimaryFlightDisplay.SettingsType {
        switch style {
        case .small:
            var config = PrimaryFlightDisplay.DefaultSmallScreenSettings()
            config.airSpeedIndicator.size.width = 0
            config.altimeter.size.width = 0
            config.headingIndicator.size.height = 0
            
            config.horizon.groundColor = SKColor.brown
            config.horizon.skyColor = SKColor.blue
            config.horizon.zeroPitchLineColor = SKColor.purple
            
            config.pitchLadder.magnitudeDisplayDegree = 0
            config.pitchLadder.fillColor = SKColor.clear
            config.pitchLadder.strokeColor = SKColor.clear
            config.pitchLadder.majorLineWidth = 0
            config.pitchLadder.minorLineWidth = 0
            return config
        case .fullScreen:
            var config = PrimaryFlightDisplay.DefaultSettings()
            config.horizon.groundColor = SKColor.brown
            return config
        }
    }
    func makeUIView(context: Context) -> PrimaryFlightDisplayView {
        let flightView = PrimaryFlightDisplayView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.frame.width,
                height: self.frame.height
            ),
            settings: self.config)
        flightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return flightView
    }

    func updateUIView(_ view: PrimaryFlightDisplayView, context: Context) {
        view.setAttitude(
            rollRadians: deg2rad(self.data.vessel.attitude.roll),
            pitchRadians: deg2rad(self.data.vessel.attitude.pitch)
        )
        view.setHeadingDegree(self.data.vessel.attitude.heading)
        view.setAirSpeed(self.data.vessel.speed.surface)
        view.setAltitude(self.data.vessel.altitude)
    }
    
    enum Style {
        case small
        case fullScreen
    }
}
