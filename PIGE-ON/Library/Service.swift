import Foundation
//
//  Service.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/19.
//
import Moya

enum Service {
    case insertProfile(firstName: String, lastName: String, description: String)
    case fetchProfileRandom
    case fetchProfileRandomArray(count: Int)
}

extension Service: TargetType {
    var baseURL: URL { URL(string: API_URL)! }

    var path: String {
        switch self {
        case .insertProfile:
            return "/insert-profile"
        case .fetchProfileRandom:
            return "/fetch-profile-random"
        case .fetchProfileRandomArray:
            return "/fetch-profile-random-array"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchProfileRandom, .fetchProfileRandomArray:
            return .get
        case .insertProfile:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .insertProfile(let firstName, let lastName, let description):
            return .requestParameters(
                parameters: [
                    "firstName": firstName, "lastName": lastName,
                    "description": description,
                ],
                encoding: JSONEncoding.default)
        case .fetchProfileRandom:
            return .requestPlain
        case .fetchProfileRandomArray(let count):
            return .requestParameters(
                parameters: ["count": count], encoding: JSONEncoding.default)
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
