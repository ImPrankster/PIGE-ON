//
//  ContentView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/1.
//

import SwiftUI

enum AppState: String {
    case profileCreation, profileComplete
}
struct ContentView: View {
    @AppStorage("app_state") var appState: AppState = .profileCreation

    var body: some View {
        if appState == .profileCreation {
            Profile()
        }
    }
}

#Preview {
    ContentView()
}
