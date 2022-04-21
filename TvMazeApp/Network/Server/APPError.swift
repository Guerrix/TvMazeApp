//
//  APIError.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation

enum APPError: Error {
    case unableToParseJSON
    case noInternet
}

extension APPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToParseJSON: return "JSON Parsing Error"
        case .noInternet: return "Oops, something went wrong"
        }
    }

    public var failureReason: String? {
        switch self {
        case .unableToParseJSON: return "Parsing Error"
        case .noInternet: return "An error occurred while fetching data. Do you want to try again?"
        }
    }
}
