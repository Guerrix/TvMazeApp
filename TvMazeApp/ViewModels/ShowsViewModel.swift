//
//  ShowsViewModel.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
class ShowsViewModel {
    let feedType: FeedType

    init(with feedType: FeedType = .all) {
        self.feedType = feedType
    }
}

// MARK: - FeedType
extension ShowsViewModel {
    enum FeedType {
        case all
        case favorite
    }
}
