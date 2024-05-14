//
//  ThemeFeatureCell.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/14.
//

import UIKit

import SnapKit
import Then

final class ThemeFeatureCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 7.0
        $0.clipsToBounds = true
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.separator.cgColor
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15.0, weight: .regular)
        $0.textColor = .label
    }
    
    // MARK: - Init
    
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
    
    func prepare(with data: ThemeFeature?) {
        titleLabel.text = data?.title
    }
}

// MARK: - Private Methods

private extension ThemeFeatureCell {
    func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.8 * contentView.bounds.height)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview().inset(10)
        }
    }
}
