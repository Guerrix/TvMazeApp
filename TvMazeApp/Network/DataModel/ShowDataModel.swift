//
//  ShowDataModel.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
import ObjectMapper

import RxSwift

struct ShowDataModel {
    func getAll() -> Observable<[Show]> {
        let data: Observable<[[String: Any]]> = Server.performRequest(ShowRouter.getAll)
        return data
            .flatMapLatest { json -> Observable<[Show]> in
                guard let shows = Mapper<Show>().mapArray(JSONObject: json) else {
                    return Observable.error(APIError.parsingError)
                }
                DBManager.add(shows)
                return Observable.just(shows)
            }
    }
}
