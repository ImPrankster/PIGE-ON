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
}

extension Service: TargetType {
    var baseURL: URL { URL(string: API_URL)! }

    var path: String {
        switch self {
        case .hello:
            return "/"
        case .insertProfile:
            return "/insert-profile"
        }
    }

    var method: Moya.Method {
        switch self {
        case .hello:
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
