//
//  Fonts.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
import UIKit

enum Fonts: String {
    case helvetica = "Helvetica"

    func font(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: rawValue, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
