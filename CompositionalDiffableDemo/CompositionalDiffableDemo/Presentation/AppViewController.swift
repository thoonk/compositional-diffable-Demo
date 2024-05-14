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
//            case .themeFeature:
//                return self.getLayoutThemeFeatureSection()
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
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1)),
            elementKind: SupplementaryKind.footer,
            alignment: .bottom
        )
        section.boundarySupplementaryItems = [sectionFooter]
        
        return section
    }
    
    func getLayoutRankingFeatureSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1.0/3.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)),
            elementKind: SupplementaryKind.header,
            alignment: .top
        )
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1)),
            elementKind: SupplementaryKind.footer,
            alignment: .bottom
        )
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        return section
    }
    
    func getLayoutThemeFeatureSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func configureAppDataSource() -> AppDataSource {
        let featureCellRegistration = FeatureRegistration { cell, _ , feature in
            cell.prepare(with: feature)
        }
        let rankingFeatureCellRegistration = RankingFeatureRegistration { cell, _ , feature in
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
//            case .themeFeature(_):
//                return UICollectionViewCell()
            }
        }
    }
    
    func configureSupplementaryViewRegistration() {
        let headerRegistration = HeaderRegistration(elementKind: SupplementaryKind.header) { view, _, indexPath in
            view.prepare(title: "지금 주목해야 할 앱", description: "새로 나온 앱과 업데이트")
        }
        
        let footerRegistration = FooterRegistration(elementKind: SupplementaryKind.footer) { view, _, indexPath in
        }
        
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
    
    func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<AppSection, AppSectionItem>()
        
        let sections = AppSection.allCases
        snapshot.appendSections(sections)
        
        snapshot.appendItems(Mocks.features, toSection: .feature)
        snapshot.appendItems(Mocks.rankingFeatures, toSection: .rankingFeature)
//        snapshot.appendItems([Mocks.themeFeatures], toSection: .themeFeature)
        
        appDataSource.apply(snapshot, animatingDifferences: true)
    }
}
