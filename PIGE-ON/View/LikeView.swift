//
//  LikeView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/12/9.
//

import SwiftUI

struct LikeView: View {
    @State var profileArr: [ProfileInfo] = []

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            if profileArr.count > 0 {
                List(profileArr, id: \.uniqueId) { item in
                    Section {
                        HStack {
                            Text(item.firstName)
                                .font(.headline)
                                .foregroundColor(.white)
                                .bold()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text(item.lastName)
                                .font(.headline)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .listRowInsets(
                        .init(
                            top: 0,
                            leading: 40,
                            bottom: 0,
                            trailing: 40
                        )
                    )
                    .listRowBackground(Color.orange)

                }
                .scrollContentBackground(.hidden)
                .listStyle(.sidebar)
                .listSectionSpacing(8)
                .contentMargins(.all, 0, for: .scrollContent).environment(
                    \.defaultMinListRowHeight, 80
                )
                .padding()
            } else {
                ProgressView()
                Spacer()
            }
        }.onAppear {
            service.request(
                .fetchLike,
                completion: {
                    result in
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

#Preview {
    LikeView(profileArr: [
        ProfileInfo(
            uniqueId: UUID(), userId: "000", firstName: "LEO", lastName: "WANG",
            description: "COOL"
        ),
        ProfileInfo(
            uniqueId: UUID(), userId: "000", firstName: "LEO", lastName: "WANG",
            description: "COOL"
        ),
    ]
    )
}
