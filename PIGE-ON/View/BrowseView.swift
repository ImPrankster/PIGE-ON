//  BrowseView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/21.
//
import SwiftUI

struct BrowseView: View {
    @StateObject var viewModel = BrowseModel()
    let appState = AppState.global

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.profileArr.count > 0 {
                ZStack {
                    
                }
                Spacer()
                Button(action: {
                    Task {

                    }
                }) {
                    Text("Next Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Browse")
    }
}

// MARK: - Preview
struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BrowseView()
        }
    }
}
