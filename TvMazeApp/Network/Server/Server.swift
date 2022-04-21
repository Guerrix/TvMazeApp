//
//  Server.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Alamofire
import Foundation
import RxSwift

struct Server {
    // Can't init is singleton
    private init() {}

    // MARK: - Private Vars
    private static var shared = Server()
    var manager: Session = {
        let config = URLSessionConfiguration.default
        // CachePolicy
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        return Session(configuration: config)
    }()
}

// MARK: - API URL
extension Server {
    static var apiURL: URL {
        let serverURL = "https://api.tvmaze.com"
        return URL(string: serverURL)!
    }
}

// MARK: - Generic Request Performers
extension Server {
    static func performRequest<T>(_ urlRequest: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = Server.shared.manager.request(urlRequest)
                .validate()
                .responseData(completionHandler: { response in
                    switch response.result {
                    case let .success(data):
                        do {
                            let json = try JSONSerialization.jsonObject(with: data)
                            guard let jsonResult = json as? T else {
                                return observer.onError(APPError.unableToParseJSON)
                            }

                            observer.onNext(jsonResult)
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }

                    case let .failure(error):
                        if case let .sessionTaskFailed(taskError) = error,
                           taskError._code == NSURLErrorNotConnectedToInternet {
                            observer.onError(APPError.noInternet)
                        } else {
                            observer.onError(error)
                        }
                    }
                })

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
