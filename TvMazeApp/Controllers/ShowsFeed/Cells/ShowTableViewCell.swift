//
//  ShowTableViewCell.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Kingfisher
import Reusable
import SnapKit
import UIKit

final class ShowTableViewCell: UITableViewCell, Reusable {
    // MARK: - UI
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.helvetica.font(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()

    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(80)
        }
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImage, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(7)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with show: Show) {
        nameLabel.text = show.name
        posterImage.kf.setImage(with: show.mediumImageURL)
    }
}
