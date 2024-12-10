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
    case fetchProfileRandomArray(count: Int)
    case insertLike(profileId:String)
    case fetchLike
}

extension Service: TargetType {
    var baseURL: URL { URL(string: API_URL)! }

    var path: String {
        switch self {
        case .insertProfile:
            return "/insert-profile"
        case .fetchProfileRandomArray:
            return "/fetch-profile-random-array"
        case .insertLike:
            return "/insert-like"
        case .fetchLike:
            return "/fetch-likes"
        }
    }

    var method: Moya.Method {
        switch self {
        case .insertProfile, .fetchProfileRandomArray, .insertLike:
            return .post
        case .fetchLike:
            return .get
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
        case .fetchProfileRandomArray(let count):
            return .requestParameters(
                parameters: ["count": count], encoding: JSONEncoding.default)
        case .insertLike(let profileId):
            return .requestParameters(parameters: [
                "profileId": profileId
            ], encoding: JSONEncoding.default)
        case .fetchLike:
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
