//
//  ShowRouter.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Alamofire
import Foundation

enum ShowRouter: URLRequestConvertible {
    case getAll

    var method: HTTPMethod {
        switch self {
        case .getAll: return .get
        }
    }

    var path: String {
        switch self {
        case .getAll: return "/shows"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = Server.apiURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method

        return request
    }
}
