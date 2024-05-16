//
//  HeaderView.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/14.
//

import UIKit

import SnapKit
import Then

final class HeaderView: UICollectionReusableView {
    
    // MARK: - UI Components
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 23.0, weight: .bold)
        $0.textColor = .label
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
        $0.textColor = .secondaryLabel
    }
    
    private lazy var viewAllButton = UIButton().then {
        $0.setTitle("모두 보기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .regular)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    func prepare(title: String?, description: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

// MARK: - Private Methods

private extension HeaderView {
    func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(15)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        addSubview(viewAllButton)
        viewAllButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(30)
        }
    }
}
