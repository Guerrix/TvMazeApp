//
//  UIViewController+.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 21/04/22.
//

import UIKit
// MARK: - Display Alert from Error
extension UIViewController {
    func displayAlert(with error: Error, retryAction: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            var title = "Oops, something went wrong"
            var message = error.localizedDescription
            if let localizedError = error as? LocalizedError {
                title = localizedError.localizedDescription
                message = localizedError.failureReason ?? message
            }

            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)

            if retryAction.isSome {
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    retryAction?()
                }))
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
    }
}
