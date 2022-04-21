//
//  ShowDataModel.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
import ObjectMapper
import RealmSwift
import RxSwift

struct ShowDataModel {
    func getAll() -> Observable<[Show]> {
        let data: Observable<[[String: Any]]> = Server.performRequest(ShowRouter.getAll)
        return data
            .flatMapLatest { json -> Observable<[Show]> in
                guard let shows = Mapper<Show>().mapArray(JSONObject: json) else {
                    return Observable.error(APPError.unableToParseJSON)
                }

                // Persist Favorited before update from server
                DBManager.objects(Show.self)
                    .compactMap { $0 } // Result to Array
                    .filter { $0.favorited }
                    .forEach { show in
                        if let serverShow = shows.first(where: { show.id == $0.id }) {
                            serverShow.favorited = true
                        }
                    }

                // Update Shows from Server
                DBManager.add(shows)

                return Observable.just(shows)
            }
    }
}
