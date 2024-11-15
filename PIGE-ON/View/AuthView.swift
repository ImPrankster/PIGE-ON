import SafariServices
//
//  AuthView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/8.
//
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    @Binding var url: URL

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<SafariView>
    ) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: UIViewControllerRepresentableContext<SafariView>
    ) {}
}

struct AuthView: View {

    @State private var showSafari = false
    @State private var signInUrl: URL = .init(string: "https://randomUrl")!

    var body: some View {
        VStack {
            Button("Login with Github") {
                Task {
                    do {
                        signInUrl = try supabase.auth.getOAuthSignInURL(
                            provider: .github,
                            redirectTo: URL(string: "pigeon://auth-callback")!)
                        showSafari = true
                    } catch {
                        print("Sign in error")
                    }
                }
            }.buttonStyle(.borderedProminent)
        }.sheet(isPresented: $showSafari) {
            SafariView(url: $signInUrl)
        }.padding().navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        AuthView()
    }
}
