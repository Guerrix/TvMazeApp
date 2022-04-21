//
//  ShowsViewController.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import UIKit

class ShowsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ShowsViewModel

    // MARK: - Init
    init(with feedType: ShowsViewModel.FeedType = .all) {
        viewModel = ShowsViewModel(with: feedType)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

// MARK: - Private API
private extension ShowsViewController {
    func configureUI() {
        view.backgroundColor = .white
        switch viewModel.feedType {
        case .all:
            navigationItem.title = "TV Shows"
        case .favorite:
            navigationItem.title = "Favorited"
        }

    }
}
