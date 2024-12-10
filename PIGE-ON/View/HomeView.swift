//
//  HomeView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/12/9.
//

import SwiftUI

enum Tabs: Equatable, Hashable {
    case browse
    case likes
}

struct TabButton: View {
    let name: String
    let icon: String
    let tab: Tabs
    @Binding var setTab: Tabs

    var fgColor: Color {
        if tab == setTab {
            return .white
        } else {
            return .indigo
        }
    }

    var body: some View {
        Button(name, systemImage: icon) {
            setTab = tab
        }
        .font(.system(size: 16, weight: .bold, design: .rounded))
        .foregroundStyle(fgColor)
        .padding(14)
        .background {
            if tab == setTab {
                Capsule()
                    .fill(.indigo)
            } else {
                Color.clear
            }
        }
        .padding(.top, 16)
    }

}

struct HomeView: View {
    let appState = AppState.global
    let user = supabase.auth.currentUser
    @State private var selectedTab: Tabs = .browse

    var body: some View {
        VStack {
            switch selectedTab {
            case .browse:
                BrowseView()
            case .likes:
                LikeView()
            }
            HStack {
                Spacer()
                TabButton(
                    name: "Browse", icon: "bird.fill", tab: .browse,
                    setTab: $selectedTab)
                Spacer()
                TabButton(
                    name: "Likes", icon: "heart.fill", tab: .likes,
                    setTab: $selectedTab)
                Spacer()
                Button("Sign out") {
                    Task {
                        try await supabase.auth.signOut()
                        appState.appState = .auth
                    }
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.red)
                .padding(.top, 16)
                Spacer()
            }.background(.background)
        }.onAppear {
            if user == nil {
                appState.appState = .auth
            }
        }
    }
}

#Preview {
    HomeView()
}
