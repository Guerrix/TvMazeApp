//
//  ShowsViewModel.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
import RxCocoa
import RxRealm
import RxSwift

struct ShowsViewModel {
    // MARK: - Properties
    private let bag = DisposeBag()
    let feedType: FeedType

    // MARK: - Input
    let refreshTrigger = PublishRelay<Void>()

    // MARK: - Outputs
    let isLoading = BehaviorRelay<Bool>(value: false)
    let shows = BehaviorRelay<[Show]>(value: [])

    // MARK: - Init
    init(with feedType: FeedType = .all) {
        self.feedType = feedType
        setupBindings()
        // Initial Load
        if DBManager.objects(Show.self).isEmpty {
            refreshTrigger.accept(())
        }
    }

    func toggleFavorite(for show: Show) {
        DBManager.write {
            show.favorited = !show.favorited
        }
    }
}

// MARK: - FeedType
extension ShowsViewModel {
    enum FeedType {
        case all
        case favorite
    }
}

// MARK: - Private API
private extension ShowsViewModel {
    func setupBindings() {
        let dbShows = DBManager.objects(Show.self)
        Observable.collection(from: dbShows)
            .map { Array($0) }
            .map { shows in
                switch feedType {
                case .all:
                    return shows
                case .favorite:
                    return shows.filter { $0.favorited }
                }
            }
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(to: shows)
            .disposed(by: bag)

        refreshTrigger.asObservable()
            .flatMapLatest { _ -> Observable<[Show]>in
                self.isLoading.accept(true)
                return API.Shows.getAll()
                    .do(onNext: { _ in self.isLoading.accept(false) },
                        onError: { _ in self.isLoading.accept(false) })
            }
            .subscribe()
            .disposed(by: bag)
    }
}
