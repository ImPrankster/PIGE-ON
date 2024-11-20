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
}

extension Service: TargetType {
    var baseURL: URL { URL(string: API_URL)! }

    var path: String {
        switch self {
        case .hello:
            return "hello"
        }
    }

    var method: Moya.Method {
        switch self {
        case .hello:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .hello:
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
