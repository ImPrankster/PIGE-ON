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
        NavigationStack {
            switch appState.appState {
            case .auth:
                AuthView()
            case .profileCreation:
                Profile()
            case .profileComplete:
                BrowseView()
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
