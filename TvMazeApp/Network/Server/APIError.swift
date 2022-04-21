//
//  APIError.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation

enum APIError: Error {
    case parsingError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .parsingError: return "Parsing Error"
        }
    }
}
