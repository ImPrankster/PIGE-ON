//
//  Global.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/5.
//
import Foundation

enum AppError: Error {
    case NotPigeonError
    case UnableToPredict
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .NotPigeonError:
            return "We do not welcome non-pigeon users"
        case .UnableToPredict:
            return "We are unable to parse this Image"
        }
    }
}
