import Foundation
//
//  Service.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/19.
//
import Moya

enum Service {
    case hello
    case insertProfile(firstName: String, lastName: String, description: String)
    case fetchProfileRandom
}

extension Service: TargetType {
    var baseURL: URL { URL(string: API_URL)! }

    var path: String {
        switch self {
        case .hello:
            return "/"
        case .insertProfile:
            return "/insert-profile"
        case .fetchProfileRandom:
            return "/fetch-profile-random"
        }
    }

    var method: Moya.Method {
        switch self {
        case .hello, .fetchProfileRandom:
            return .get
        case .insertProfile:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .hello:
            return .requestPlain
        case .insertProfile(let firstName, let lastName, let description):
            return .requestParameters(
                parameters: ["firstName": firstName, "lastName": lastName, "description": description],
                encoding: JSONEncoding.default)
        case .fetchProfileRandom:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        let accessToken = supabase.auth.currentSession?.accessToken ?? ""
        let refreshToken = supabase.auth.currentSession?.refreshToken ?? ""
        return [
            "Content-type": "application/json", "X-access-token": accessToken,
            "X-refresh-token": refreshToken,
        ]
    }
}

let service = MoyaProvider<Service>()
