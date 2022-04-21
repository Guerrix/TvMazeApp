//
//  ShowDetailViewModel.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 21/04/22.
//

import RxCocoa
import RxOptional
import RxSwift

struct ShowDetailViewModel {
    // MARK: - Properties
    private let bag = DisposeBag()
    let show = BehaviorRelay<Show>(value: Show())
    // MARK: - Init
    init(with show: Show) {
        self.show.accept(show)
        setupBindings()
    }

    func toggleShowFavorite() {
        DBManager.write {
            show.value.favorited = !show.value.favorited
        }
    }
}

// MARK: - Private API
private extension ShowDetailViewModel {
    func setupBindings() {
        let dbShows = DBManager.objects(Show.self)
        Observable.collection(from: dbShows)
            .map { $0.first(where: { $0.id == show.value.id }) }
            .filterNil()
            .bind(to: show)
            .disposed(by: bag)
    }
}
