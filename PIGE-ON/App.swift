//
//  PIGE_ONApp.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/1.
//

import SwiftUI

let PUBLIC_SUPABASE_URL = "https://gpafnkazyfmogkujuqxz.supabase.co"
let PUBLIC_SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwYWZua2F6eWZtb2drdWp1cXh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwODE4MDEsImV4cCI6MjA0NjY1NzgwMX0.Njn7WNM2avGfx5G5LpLma1sssi-HQZ5ai0ECUfLr0e4"
let API_URL = "https://pigeon.leow.io"

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
    var appState = AppState.global

    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL(
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
