//
//  MainMenu.swift
//  KerbalKompanion
//
//  Created by Noah Kamara on 15.03.20.
//  Copyright © 2020 Noah Kamara. All rights reserved.
//

import SwiftUI

struct MainMenu: View {
    @Binding var selectedView: MainView.MainView
    var body: some View {
        VStack(spacing: 22) {
            MenuItem(
                icon: "antenna.radiowaves.left.and.right",
                selectedView: self.$selectedView,
                view: .panels
            )
            
            MenuItem(
                icon: "gamecontroller.fill",
                selectedView: self.$selectedView,
                view: .controll
            )
            
            MenuItem(
                icon: "tv.fill",
                selectedView: self.$selectedView,
                view: .flightDisplay
            )
            
            MenuItem(
                icon: "map.fill",
                selectedView: self.$selectedView,
                view: .map
            )
            
            MenuItem(
                icon: "square.grid.2x2.fill",
                selectedView: self.$selectedView,
                view: .grid
            )
            Spacer()
        }.frame(width: 300).padding(.top, 12)
    }
    struct MenuItem: View {
        var icon: String
        @Binding var selectedView: MainView.MainView
        var view:  MainView.MainView
        
        var body: some View {
            Button(action: {
                self.selectedView = self.view
            }) {
                RoundedBackground(isInner: (self.selectedView == self.view))
                .overlay(
                    HStack {
                        Image(systemName: self.icon).padding()
                    }.font(.system(.headline, design: .monospaced))
                )
                    .frame(width: 60, height: 60)
            }.buttonStyle(NMButton(isActive: self.selectedView == self.view))
                .accentColor(.primary)
                .frame(width: 100)
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(selectedView: .constant(.panels))
    }
}
