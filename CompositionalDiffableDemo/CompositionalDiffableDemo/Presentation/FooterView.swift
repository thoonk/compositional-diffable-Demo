//
//  FooterView.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/14.
//

import UIKit

final class FooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .separator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
