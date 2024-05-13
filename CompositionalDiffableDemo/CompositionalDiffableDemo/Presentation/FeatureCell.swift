//
//  FeatureCell.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/13.
//

import UIKit

import SnapKit
import Then

final class FeatureCell: UICollectionViewCell {
    
    private lazy var typeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0, weight: .semibold)
        $0.textColor = .systemBlue
    }
    
    private lazy var appNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = .label
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .semibold)
        $0.textColor = .secondaryLabel
    }
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 7.0
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.separator.cgColor
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .tertiarySystemGroupedBackground
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
    
    func prepare(with data: Feature?) {
        typeLabel.text = data?.type
        appNameLabel.text = data?.title
        descriptionLabel.text = data?.description
    }
}

// MARK: - Private Methods

private extension FeatureCell {
    func setupLayout() {
        contentView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
