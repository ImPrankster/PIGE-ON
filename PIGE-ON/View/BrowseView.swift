//  BrowseView.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/21.
//
import SwiftUI

struct ProfileInfo: Decodable {
    var firstName: String?
    var lastName: String?
    var description: String?
}

struct BrowseView: View {
    @State var profileInfo = ProfileInfo(
        firstName: nil, lastName: nil, description: nil)

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.gray)
                .padding(.top, 30)

            Text(
                "\(profileInfo.firstName ?? "First") \(profileInfo.lastName ?? "Last")"
            )
            .font(.title)
            .fontDesign(.serif)
            .bold()

            Text(profileInfo.description ?? "No description available")
                .font(.body)
                .fontDesign(.serif)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(action: {
                Task {
                    service.request(
                        .fetchProfileRandom,
                        completion: {
                            result in
                            switch result {
                            case let .success(moyaResponse):
                                let data = moyaResponse.data  // Data, your JSON response is probably in here!
                                let statusCode = moyaResponse.statusCode  // Int - 200, 401, 500, etc

                                if statusCode >= 200 && statusCode < 300 {
                                    let decoded =
                                        try? JSONDecoder().decode(
                                            ProfileInfo.self, from: data)
                                    if let data = decoded {
                                        profileInfo = data
                                    } else {
                                        print("Invalid response")
                                    }
                                } else {
                                    print("Fetching profile failed")
                                }

                            case .failure(_):
                                print("Fetching profile failed")
                            }
                        })
                }
            }) {
                Text("Next Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
                    .background(Color.blue)
                    .cornerRadius(20)
            }

        }.onAppear {
            Task {
                service.request(
                    .fetchProfileRandom,
                    completion: {
                        result in
                        switch result {
                        case let .success(moyaResponse):
                            let data = moyaResponse.data  // Data, your JSON response is probably in here!
                            let statusCode = moyaResponse.statusCode  // Int - 200, 401, 500, etc

                            if statusCode >= 200 && statusCode < 300 {
                                let decoded =
                                    try? JSONDecoder().decode(
                                        ProfileInfo.self, from: data)
                                if let data = decoded {
                                    profileInfo = data
                                } else {
                                    print("Invalid response")
                                }
                            } else {
                                print("Fetching profile failed")
                            }

                        case .failure(_):
                            print("Fetching profile failed")
                        }
                    })
            }
        }
    }
}

// MARK: - Preview
struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview with sample data
            BrowseView(
                profileInfo: ProfileInfo(
                    firstName: "John",
                    lastName: "Doe",
                    description:
                        "Hey there! I'm a passionate photographer and nature enthusiast. Love capturing beautiful moments and sharing them with the world."
                ))
        }
    }
}
