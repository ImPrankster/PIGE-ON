//
//  AppState.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/14.
//
import SwiftUI

enum AppStateEnum: String {
    case auth, profileCreation, profileComplete
}

class AppState: ObservableObject {
    static let global = AppState()
    @AppStorage("app_state") var appState: AppStateEnum = .auth
}
