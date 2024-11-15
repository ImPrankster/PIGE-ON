//
//  PIGE_ONApp.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/1.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ app: UIApplication, open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        print("url")
        return true
    }
}

@main
struct PIGE_ONApp: App {
    var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appState).onOpenURL(
                perform: handleURL)
        }
    }

    func handleURL(_ url: URL) {
        if url.host == "auth-callback" {
            Task {
                do {
                    _ = try await supabase.auth.session(from: url)
                    print("### Successful oAuth")
                    appState.appState = .profileCreation
                } catch {
                    print("### oAuthCallback error: \(error)")
                }
            }
        }
    }
}
