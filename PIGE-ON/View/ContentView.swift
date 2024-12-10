//
//  ContentView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState.global

    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            Image(systemName: "cloud.fill").resizable().scaledToFit().frame(
                width: 125
            ).position(x: 75, y: 150).foregroundStyle(.white)
            Image(systemName: "cloud.fill").resizable().scaledToFit().frame(
                width: 256
            ).position(x: 300, y: 10).foregroundStyle(.white)
            Image(systemName: "cloud.fill").resizable().scaledToFit().frame(
                width: 125
            ).position(x: 30, y: 0).foregroundStyle(.white)
            switch appState.appState {
            case .auth:
                AuthView()
            case .profileCreation:
                Profile()
            case .profileComplete:
                HomeView()
            }
        }.fontDesign(.rounded)
    }
}

#Preview {
    ContentView()
}
