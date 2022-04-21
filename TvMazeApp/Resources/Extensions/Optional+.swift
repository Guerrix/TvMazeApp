//
//  Optional+.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 21/04/22.
//

import Foundation

protocol OptionalType {
    associatedtype WrapType

    var isSome: Bool { get }
    var isNone: Bool { get }

    var unsafelyUnwrapped: WrapType { get }
}

extension Optional: OptionalType {
    /// Returns `true` if optional is different to `nil`
    var isSome: Bool {
        return self != nil
    }

    //// Returns `true` if optional is `nil`
    var isNone: Bool {
        return !isSome
    }
}

