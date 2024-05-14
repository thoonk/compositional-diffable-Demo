//
//  RankingFeatureCell.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/13.
//

import UIKit

import SnapKit
import Then

final class RankingFeatureCell: UICollectionViewCell {
    private lazy var imageView = UIImageView().then {
        $0.layer.cornerRadius = 7.0
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.separator.cgColor
        $0.backgroundColor = .tertiarySystemGroupedBackground
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.textColor = .label
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13.0, weight: .semibold)
        $0.textColor = .secondaryLabel
    }
    
    private lazy var downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 12.0
        $0.clipsToBounds = true
    }
    
    private lazy var inAppPurchaseInfoLabel = UILabel().then {
        $0.text = "앱 내 구입"
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.textColor = .secondaryLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        prepare(with: nil)
    }
    
    func prepare(with data: RankingFeature?) {
        titleLabel.text = data?.title
        descriptionLabel.text = data?.description
    }
}

private extension RankingFeatureCell {
    func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(imageView.snp.height)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(8)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        contentView.addSubview(downloadButton)
        downloadButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(24)
        }
        
        contentView.addSubview(inAppPurchaseInfoLabel)
        inAppPurchaseInfoLabel.snp.makeConstraints {
            $0.top.equalTo(downloadButton.snp.bottom).offset(4)
            $0.centerX.equalTo(downloadButton.snp.centerX)
        }
    }
}
