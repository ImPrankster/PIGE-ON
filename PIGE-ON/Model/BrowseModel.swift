//
//  BrowseModel.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/22.
//
import SwiftUI

struct ProfileInfo: Decodable {
    var userId: String
    var firstName: String
    var lastName: String
    var description: String
}

let TOTAL = 4

@MainActor
class BrowseModel: ObservableObject {
    @Published var profileArr: [ProfileInfo] = []
    var user = supabase.auth.currentUser
    var appState = AppState.global
    
    init () {
        if user == nil {appState.appState = .auth}
        self.populate()
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
                                self.profileArr.append(contentsOf: data)
                            } else {
                                print("Invalid response")
                            }
                        } else {
                            print("Fetching profile failed with \(statusCode)")
                        }

                    case .failure(_):
                        print("Fetching profile failed")
                    }
                })
        }
    }

}
