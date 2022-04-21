//
//  Show.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
import ObjectMapper
import RealmSwift

final class Show: Object, Mappable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted private var mediumImageStringURL: String?
    @Persisted var favorited = false

    // MARK: - Mappable Init
    required convenience init?(map _: ObjectMapper.Map) {
        self.init()
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Show {
    var mediumImageURL: URL? {
        guard let urlString = mediumImageStringURL else {
            return nil
        }
        return URL(string: urlString)
    }
}

// MARK: - Mappable
extension Show {
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        mediumImageStringURL <- map["image.medium"]
    }
}
