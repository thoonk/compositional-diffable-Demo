# Compositional Layout + Diffable DataSource를 적용한 데모 프로젝트

- AppStore 앱 레이아웃을 클론하여 구현 
- Compositional 과 Diffable DataSource 적용
- 코드 작성 편의성을 위한 SnapKit 과 Then 라이브러리 사용
  
## Compositional Layout
### Compositional Layout 정의
하나의 콜렉션 뷰에 섹션 별로 다른 레이아웃 정의

```
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
```

### Section 정의
```
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
```

### 최상단 섹션 레이아웃 정의
다음 아이템 노출을 위해 group .fractionalWidth(0.9) 설정 및 horizontal로 설정
```
func getLayoutFeatureSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
    
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
```

### 랭킹 차트 섹션 정의

다음 아이템 노출을 위해 group `.fractionalWidth(0.9)` 설정 

한 Group 당 3개의 item을 노출하기 위해 group `.fractionalHeight(1.0/3.0)` 설정

```
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
```

### 테마 섹션 정의

다음 아이템 노출을 위해 group `.fractionalWidth(0.65)` 설정

```
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
```

### 헤더 및 푸터 정의
```
private enum SupplementaryKind {
    static let header = "section-header-element-kind"
    static let footer = "section-footer-element-kind"
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
```
