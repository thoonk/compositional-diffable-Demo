//
//  AppViewController.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/10.
//

import UIKit

import SnapKit
import Then

final class AppViewController: UIViewController {
    
    private enum SupplementaryKind {
        static let header = "section-header-element-kind"
        static let footer = "section-footer-element-kind"
    }
    
    fileprivate typealias AppDataSource = UICollectionViewDiffableDataSource<AppSection, AppSectionItem>
    private typealias FeatureRegistration = UICollectionView.CellRegistration<FeatureCell, Feature>
    private typealias RankingFeatureRegistration = UICollectionView.CellRegistration<RankingFeatureCell, RankingFeature>
    private typealias ThemeFeatureRegistration = UICollectionView.CellRegistration<ThemeFeatureCell, ThemeFeature>
    private typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<HeaderView>
    private typealias FooterRegistration = UICollectionView.SupplementaryRegistration<FooterView>
    
    private lazy var appDataSource = configureAppDataSource()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
            guard let sectionKind = AppSection(rawValue: section) else { return nil }
            switch sectionKind {
            case .feature:
                return self.getLayoutFeatureSection()
            case .rankingFeature:
                return self.getLayoutRankingFeatureSection()
            case .themeFeature:
                return self.getLayoutThemeFeatureSection()
            }
        }).then {
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = .zero
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
        applyInitialSnapshots()
        configureSupplementaryViewRegistration()
    }
}

// MARK: - Private Methods

private extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func getLayoutFeatureSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let sectionFooter = configureSeparatorFooter()
        section.boundarySupplementaryItems = [sectionFooter]
        
        return section
    }
    
    func getLayoutRankingFeatureSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1.0/3.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let sectionHeader = configureSectionHeader()
        let sectionFooter = configureSeparatorFooter()
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        return section
    }
    
    func getLayoutThemeFeatureSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.65),
            heightDimension: .fractionalHeight(0.25)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        let sectionHeader = configureSectionHeader()
        let sectionFooter = configureSeparatorFooter()
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        return section
    }
    
    func configureAppDataSource() -> AppDataSource {
        let featureCellRegistration = FeatureRegistration { cell, _ , feature in
            cell.prepare(with: feature)
        }
        let rankingFeatureCellRegistration = RankingFeatureRegistration { cell, _ , feature in
            cell.prepare(with: feature)
        }
        let themeFeatureCellRegistration = ThemeFeatureRegistration { cell, _, feature in
            cell.prepare(with: feature)
        }
        
        return AppDataSource(collectionView: collectionView) { collectionView, indexPath, listItem in
            switch listItem {
            case .feature(let feature):
                return collectionView.dequeueConfiguredReusableCell(
                    using: featureCellRegistration,
                    for: indexPath,
                    item: feature
                )
            case .rankingFeature(let feature):
                return collectionView.dequeueConfiguredReusableCell(
                    using: rankingFeatureCellRegistration,
                    for: indexPath,
                    item: feature
                )
            case .themeFeature(let feature):
                return collectionView.dequeueConfiguredReusableCell(
                    using: themeFeatureCellRegistration,
                    for: indexPath,
                    item: feature
                )
            }
        }
    }
    
    func configureSupplementaryViewRegistration() {
        let headerRegistration = HeaderRegistration(elementKind: SupplementaryKind.header) { view, _, indexPath in
            if let section =  AppSection(rawValue: indexPath.section) {
                view.prepare(title: section.headerTitle, description: section.description)
            }
        }
        
        let footerRegistration = FooterRegistration(elementKind: SupplementaryKind.footer, handler: { _, _, _ in })
        
        appDataSource.supplementaryViewProvider = { [weak self] _ , kind, index in
            switch kind {
            case SupplementaryKind.header:
                return self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
            case SupplementaryKind.footer:
                return self?.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    func configureSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(50)
            ),
            elementKind: SupplementaryKind.header,
            alignment: .top
        )
    }
    
    func configureSeparatorFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(1)
            ),
            elementKind: SupplementaryKind.footer,
            alignment: .bottom
        )
    }
    
    func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<AppSection, AppSectionItem>()
        
        let sections = AppSection.allCases
        snapshot.appendSections(sections)
        
        snapshot.appendItems(Mocks.features, toSection: .feature)
        snapshot.appendItems(Mocks.rankingFeatures, toSection: .rankingFeature)
        snapshot.appendItems(Mocks.themeFeatures, toSection: .themeFeature)
        
        appDataSource.apply(snapshot, animatingDifferences: true)
    }
}
