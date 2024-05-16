//
//  AppSection.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/13.
//

import Foundation

enum AppSection: Int, Hashable, CaseIterable {
    case feature
    case rankingFeature
    case themeFeature
    
    var headerTitle: String? {
        switch self {
        case .feature:
            return nil
        case .rankingFeature:
            return "지금 주목해야 할 앱"
        case .themeFeature:
            return "테마별 필수 앱"
        }
    }
    
    var description: String? {
        switch self {
        case .feature:
            return nil
        case .rankingFeature:
            return "새로 나온 앱과 업데이트"
        case .themeFeature:
            return nil
        }
    }
}

enum AppSectionItem: Hashable {
    case feature(Feature)
    case rankingFeature(RankingFeature)
    case themeFeature(ThemeFeature)
}

struct Feature: Hashable {
    let type: String
    let title: String
    let description: String
    private let identifier = UUID()
}

struct RankingFeature: Hashable {
    let title: String
    let description: String
    let isInAppPurchase: Bool
    private let identifier = UUID()
}

struct ThemeFeature: Hashable {
    let title: String
    private let identifier = UUID()
}
