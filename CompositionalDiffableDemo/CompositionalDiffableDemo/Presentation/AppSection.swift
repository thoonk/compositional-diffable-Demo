//
//  AppSection.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/13.
//

import Foundation

enum AppSection: Int, Hashable, CaseIterable, CustomStringConvertible {
    case feature
    case rankingFeature
//    case themeFeature
    
    var description: String {
        switch self {
        case .feature:
            return ""
        case .rankingFeature:
            return ""
//        case .themeFeature:
//            return ""
        }
    }
}

enum AppSectionItem: Hashable {
    case feature([Feature])
    case rankingFeature([RankingFeature])
//    case themeFeature([ThemeFeature])
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
