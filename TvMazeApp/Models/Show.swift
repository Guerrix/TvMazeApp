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
    @Persisted private var tvmazeStringURL: String?
    @Persisted private var imdbID: String?
    @Persisted var language: String
    @Persisted var summary: String
    @Persisted var rating: Float
    @Persisted var genres = List<String>()
    @Persisted var favorited = false

    // MARK: - Mappable Init
    required convenience init?(map _: ObjectMapper.Map) {
        self.init()
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
// MARK: - Expose URL types
extension Show {
    var mediumImageURL: URL? {
        guard let urlString = mediumImageStringURL else {
            return nil
        }
        return URL(string: urlString)
    }

    var imdbURL: URL? {
        guard let imdbID = imdbID else {
            return nil
        }
        return URL(string: "https://www.imdb.com/title/\(imdbID)/")
    }

    var tvmazeURL: URL? {
        guard let urlString = tvmazeStringURL else {
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
        tvmazeStringURL <- map["url"]
        imdbID <- map["externals.imdb"]
        rating <- map["rating.average"]
        language <- map["language"]
        summary <- map["summary"]
        var genres = [String]()
        genres <- map["genres"]
        self.genres.append(objectsIn: genres)
    }
}
