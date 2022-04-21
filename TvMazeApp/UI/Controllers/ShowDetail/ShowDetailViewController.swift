//
//  ShowDetailViewController.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 21/04/22.
//

import Kingfisher
import RxCocoa
import RxOptional
import RxSwift
import SafariServices
import UIKit

final class ShowDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ShowDetailViewModel
    private var show: Show {
        viewModel.show.value
    }

    // MARK: - UI
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var officialLinkButton: UIButton!
    @IBOutlet weak var summaryTextView: UITextView!

    private lazy var favoriteButton: UIBarButtonItem = {
        let imageName = show.favorited ? "suit.heart.fill" : "suit.heart"
        let button = UIBarButtonItem(image: UIImage(systemName: imageName),
                                     style: .plain,
                                     target: nil,
                                     action: nil)
        button.image = UIImage(systemName: imageName)
        return button
    }()

    // MARK: - Inits
    init(with show: Show) {
        viewModel = ShowDetailViewModel(with: show)
        super.init(nibName: "ShowDetailViewController", bundle: nil)
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
        updateNavigationBar()
    }
}

// MARK: - Private API
private extension ShowDetailViewController {
    func configureUI() {
        navigationItem.rightBarButtonItem = favoriteButton
        title = show.name
        posterImage.kf.setImage(with: show.mediumImageURL)
        languageLabel.text = show.language
        raitingLabel.text = "\(show.rating)"

        imdbButton.isHidden = show.imdbURL.isNone
        officialLinkButton.isHidden = show.tvmazeURL.isNone
        genresLabel.text = Array(show.genres).joined(separator: ", ")

        summaryTextView.attributedText = show.summary.htmlToAttributedString

        let imageName = show.favorited ? "suit.heart.fill" : "suit.heart"
        favoriteButton.image = UIImage(systemName: imageName)
    }

    func setupBindings() {
        viewModel.show.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.configureUI()
            })
            .disposed(by: rx.disposeBag)

        imdbButton.rx.controlledTap
            .map { self.show.imdbURL }
            .filterNil()
            .drive(onNext: { [weak self] url in
                self?.openURL(url)
            })
            .disposed(by: rx.disposeBag)

        officialLinkButton.rx.controlledTap
            .map { self.show.tvmazeURL }
            .filterNil()
            .drive(onNext: { [weak self] url in
                self?.openURL(url)
            })
            .disposed(by: rx.disposeBag)

        favoriteButton.rx.controlledTap
            .drive(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.viewModel.toggleShowFavorite()
            })
            .disposed(by: rx.disposeBag)
    }

    func openURL(_ url: URL) {
        let safariController = SFSafariViewController(url: url)
        navigationController?.present(safariController, animated: true)
    }
}
