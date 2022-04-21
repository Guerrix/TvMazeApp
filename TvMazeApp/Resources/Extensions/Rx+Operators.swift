//
//  Rx+Operators.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 21/04/22.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - UIButton
extension Reactive where Base: UIButton {
    /// A controlled debounced version of Tap
    var controlledTap: Driver<Void> {
        return tap
            .asDriver()
            .throttle(.milliseconds(300))
    }
}

// MARK: - UIBarButtonItem
extension Reactive where Base: UIBarButtonItem {
    /// A controlled debounced version of Tap
    var controlledTap: Driver<Void> {
        return tap
            .asDriver()
            .throttle(.milliseconds(300))
    }
}

// MARK: - Generic
public extension ObservableType {
    /// Discards any element into a void element
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

