//
//  API.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
class API {
    // MARK: - API Segments
    static var Shows: ShowDataModel { return shared.shows }
    private var shows = ShowDataModel()

    // Can't init is singleton
    private init() {}

    // MARK: Shared Instance
    private static let shared = API()
}
