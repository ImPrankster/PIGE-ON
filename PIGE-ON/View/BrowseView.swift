//  BrowseView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/21.
//
import SwiftUI

struct ProfileInfo: Decodable {
    var uniqueId: UUID
    var userId: String
    var firstName: String
    var lastName: String
    var description: String
}

let TOTAL = 4

struct BrowseView: View {
    @State var profileArr: [ProfileInfo] = []
    let user = supabase.auth.currentUser
    let appState = AppState.global
    var previewMode = false

    var body: some View {
        VStack(spacing: 20) {
            if profileArr.count > 0 {
                Text(
                    profileArr.map({
                        p in
                        return p.firstName
                    }).description)
                ZStack {
                    ForEach(
                        Array(profileArr.enumerated()), id: \.1.uniqueId
                    ) {
                        index, profile in
                        CardView(
                            person: profile,
                            onSwipeLeft: {
                                profileArr.removeAll(where: {
                                    $0.uniqueId == profile.uniqueId
                                })
                                populate()
                            },
                            onSwipeRight: {
                                profileArr.removeAll(where: {
                                    $0.uniqueId == profile.uniqueId
                                })
                                populate()
                            }
                        ).zIndex(Double(10 - index))
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Browse")
        .onAppear(
            perform: {
                if user == nil && !previewMode {
                    appState.appState = .auth
                } else {
                    populate()
                }
            })
    }

    func populate() {
        if profileArr.count < TOTAL {
            print(TOTAL - profileArr.count)
            service.request(
                .fetchProfileRandomArray(count: TOTAL - profileArr.count),
                completion: { result in
                    switch result {
                    case let .success(moyaResponse):
                        let data = moyaResponse.data  // Data, your JSON response is probably in here!
                        let statusCode = moyaResponse.statusCode  // Int - 200, 401, 500, etc

                        if statusCode >= 200 && statusCode < 300 {
                            let decoded =
                                try? JSONDecoder().decode(
                                    [ProfileInfo].self, from: data)
                            if let data = decoded {
                                profileArr.append(contentsOf: data)
                                print("Fetching profile success")
                            } else {
                                print("Invalid response")
                            }
                        } else {
                            print("Fetching profile failed")
                        }

                    case let .failure(err):
                        print(err.errorDescription ?? "Error happened")
                    }
                })
        }
    }
}

// MARK: - Preview
struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BrowseView(previewMode: true)
        }
    }
}
