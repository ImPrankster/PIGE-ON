//
//  ContentView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/1.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            switch appState.appState {
            case .auth:
                AuthView()
            case .profileCreation:
                Profile()
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    @Previewable var appState = AppState()
    ContentView().environmentObject(appState)
}
