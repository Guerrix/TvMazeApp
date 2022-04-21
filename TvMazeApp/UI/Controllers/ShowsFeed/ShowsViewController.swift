//
//  ShowsViewController.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import NSObject_Rx
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class ShowsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ShowsViewModel
    private var shows: [Show] {
        viewModel.shows.value
    }

    // MARK: - UI
    private lazy var refreshControl = UIRefreshControl()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: ShowTableViewCell.self)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.refreshControl = refreshControl
        tableView.rowHeight = 94
        return tableView
    }()

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
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar(backgroundColor: .electricPurple, textColor: .white)
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

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupBindings() {
        viewModel.shows
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)

        viewModel.onError
            .asDriver(onErrorJustReturn: APPError.noInternet)
            .drive(onNext: { [weak self] error in
                self?.displayAlert(with: error) {
                    self?.viewModel.fetchShows()
                }
            })
            .disposed(by: rx.disposeBag)

        // Refresh Control
        refreshControl.rx.controlEvent(.primaryActionTriggered)
            .asObservable()
            .bind(to: viewModel.refreshTrigger)
            .disposed(by: rx.disposeBag)

        viewModel.isLoading
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension ShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShowTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let show = shows[indexPath.row]
        cell.configure(with: show)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions = [UIContextualAction]()
        let show = shows[indexPath.row]
        let title = show.favorited ? "Delete" : "Favorite"
        let favAction = UIContextualAction(style: .normal, title: title) { [weak self] _, _, complete in
            self?.viewModel.toggleFavorite(for: show)
            complete(true)
        }
        favAction.backgroundColor = show.favorited ? .red : .green
        actions.append(favAction)

        return UISwipeActionsConfiguration(actions: actions)
    }
}

// MARK: - UITableViewDelegate
extension ShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let show = shows[indexPath.row]
        let controller = ShowDetailViewController(with: show)
        navigationController?.pushViewController(controller, animated: true)
    }
}
