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
    let appState = AppState.global

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Finest Pigeons all around New York")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(.black).padding(.horizontal)
            Spacer()
            if profileArr.count > 0 {
                ZStack {
                    ForEach(
                        Array(profileArr.enumerated()), id: \.1.uniqueId
                    ) {
                        index, profile in
                        CardView(
                            person: profile,
                            onSwipeLeft: {
                                dislike(id: profile.uniqueId)
                            },
                            onSwipeRight: {
                                like(id: profile.uniqueId)
                            }
                        ).zIndex(Double(10 - index))
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button("Dislike", systemImage: "heart.slash.fill") {
                        dislike(id: profileArr[0].uniqueId)
                    }
                    .buttonStyle(BigButton(fill: Color.red))
                    Spacer()
                    Button(
                        "Like", systemImage: "heart.fill"
                    ) {
                        like(id: profileArr[0].uniqueId)
                    }.buttonStyle(BigButton(fill: Color.green))
                    Spacer()
                }
                Spacer()
            } else {
                ProgressView()
                Spacer()
            }
        }
        .onAppear(
            perform: {
                populate()
            })
    }

    func dislike(id: UUID) {
        profileArr.removeAll(where: {
            $0.uniqueId == id
        })
        populate()
    }

    func like(id: UUID) {
        service.request(
            .insertLike(
                profileId: profileArr.first(where: { $0.uniqueId == id })!
                    .userId),
            completion: {
                result in
                switch result {
                case let .success(moyaResponse):
                    let statusCode = moyaResponse.statusCode  // Int - 200, 401, 500, etc

                    if statusCode >= 200 && statusCode < 300 {
                        print("Like successfuly inserted")
                    } else {
                        print("Like failed")
                    }

                case let .failure(err):
                    print(err.errorDescription ?? "Error happened")
                }
            }
        )
        profileArr.removeAll(where: {
            $0.uniqueId == id
        })
        populate()
    }

    func populate() {
        if profileArr.count < TOTAL {
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
            BrowseView()
        }
    }
}
