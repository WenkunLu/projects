//
//  ReadLaterViewController.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/2.
//

import UIKit



class ReadLaterViewController: BasicCollectionController {
    
    var collectionView: UICollectionView!
    
    var readLaterDataSource = ReadLaterDataSource()

    var segment: UISegmentedControl!
    let gap: CGFloat = 12
    var content: Content = .book
    enum Content {
        case book
        case article
    }
    
    private var sectionsOfBook: [ReadLaterDataSource.SectionOfBook] {
        return readLaterDataSource.sectionsOfBook
    }
    private var sectionsOfArticle: [ReadLaterDataSource.SectionOfArticle] {
        return readLaterDataSource.sectionsOfArticle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //先把多重数组cells的章节填满
        switch content {
        case .book:
            for _ in sectionsOfBook {
                cells.append([])
            }
        case .article:
            for _ in sectionsOfArticle {
                cells.append([])
            }
        }
        
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - 注册cell
        collectionView.register(OneColumnCardWithShadow.self, forCellWithReuseIdentifier: OneColumnCardWithShadow.reuseID)
        collectionView.register(ThreeColumnCardWithShadow.self, forCellWithReuseIdentifier: ThreeColumnCardWithShadow.reuseID)
        collectionView.register(ArticleCardWithShdow.self, forCellWithReuseIdentifier: ArticleCardWithShdow.reuseID)
        //注册页眉
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        segment = UISegmentedControl(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width-20, height: 40))
        segment.insertSegment(withTitle: "书籍", at: 0, animated: true)
        segment.insertSegment(withTitle: "文章", at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        
        view.addSubview(collectionView)
        view.addSubview(segment)
        view.backgroundColor = .white
        self.layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cells = []
        switch content {
        case .book:
            for _ in sectionsOfBook {
                cells.append([])
            }
        case .article:
            for _ in sectionsOfArticle {
                cells.append([])
            }
        }
        collectionView.reloadData()
    }
    
    @objc func segmentDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            content = .book
            cells = []
            for _ in sectionsOfBook {
                cells.append([])
            }
            collectionView.reloadData()
        case 1:
            content = .article
            cells = []
            for _ in sectionsOfArticle {
                cells.append([])
            }
            collectionView.reloadData()
        default:
            break
        }
    }
    
    //MARK: - 眼动追踪
    
    override func determineWhetherCellsContainThePoint(point: CGPoint) {
        DispatchQueue.main.async {
            self.isContained = []
            
            for (_, section) in self.cells.enumerated() {
                for (_, item) in section.enumerated() {
                                    
                    if point.y < UIScreen.main.bounds.height - self.heightOfTabBar {
                            print(self.heightOfTabBar)
                        
                        let inset = self.view.safeAreaInsets.top
                        
                        let itemFrame = CGRect(
                            x: item.frame.minX,
                            y: item.frame.minY + inset+40+8 - self.contentOffset,
                            width: item.frame.width,
                            height: item.frame.height)
                        
                        if itemFrame.contains(point) {
                            self.isContained.append(true)
                            if self.isAppeared && self.isEyeInteractionEnabled {
                                item.layer.borderWidth = 1
                            }
                        } else {
                            self.isContained.append(false)
                            item.layer.borderWidth = 0
                        }
                        
                    } else { //矩形边界判断
                        self.isContained = []
                        item.layer.borderWidth = 0
                    }
                    
                }
            }
        }//DispatchQueue.main.async
    }
        
        
    override func performingNavigation() {
        guard isAppeared && isEyeInteractionEnabled else { return }
        DispatchQueue.main.async {
            let detailVC = BookDetailController()
            self.navigationController?.pushViewController(detailVC, animated: true)
            print("dayin", self.isContained)
        }
    }
}

//MARK: - Layout
extension ReadLaterViewController {
    func layoutViews() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: guide.topAnchor),
            segment.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15),
            segment.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -15),
            segment.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
}

//MARK: - Data Source 章节设置
extension ReadLaterViewController: UICollectionViewDataSource {
    //章节数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch content {
        case .book:
            return sectionsOfBook.count
        case .article:
            return sectionsOfArticle.count
        }
    }
    
    //每章中cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch content {
        case .book:
            return sectionsOfBook[section].books.count
        case .article:
            return sectionsOfArticle[section].articles.count
        }

    }
    
    //MARK: - 添加Cell，设置value
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let oneColumnCell = collectionView.dequeueReusableCell(withReuseIdentifier: OneColumnCardWithShadow.reuseID, for: indexPath) as! OneColumnCardWithShadow
        let threeColumnCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeColumnCardWithShadow.reuseID, for: indexPath) as! ThreeColumnCardWithShadow
        let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCardWithShdow.reuseID, for: indexPath) as! ArticleCardWithShdow
        
        
        switch content {
        case .book:
            if indexPath.section == 0 {
                oneColumnCell.value = sectionsOfBook[indexPath.section].books[indexPath.item]
                cells[0].append(oneColumnCell)
                return oneColumnCell
            } else {
                threeColumnCell.value = sectionsOfBook[indexPath.section].books[indexPath.item]
                cells[indexPath.section].append(threeColumnCell)
                return threeColumnCell
            }
        case .article:
            articleCell.value = sectionsOfArticle[indexPath.section].articles[indexPath.item]
            cells[indexPath.section].append(articleCell)
            return articleCell
        
        }
    }
  
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID, for: indexPath) as! SectionHeaderView
        
        switch content {
        case .book:
            header.value = sectionsOfBook[indexPath.section].header
            return header
        case .article:
            header.value = sectionsOfArticle[indexPath.section].header
            return header
        }
        
    }
    
}

//MARK: - Delegate 选中cell
extension ReadLaterViewController: UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch content {
        case .book:
            let vc = BookDetailController()
            vc.value = sectionsOfBook[indexPath.section].books[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        case .article:
            let vc = ArticleDetailController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset = scrollView.contentOffset.y
    }
}

//MARK: - FlowLayout 设置cell尺寸
extension ReadLaterViewController: UICollectionViewDelegateFlowLayout {
    
    //设置cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = view.safeAreaInsets
        let safeAreaWidth = UIScreen.main.bounds.width - insets.left - insets.right
        
        switch content {
        case .book:
            switch sectionsOfBook[indexPath.section].cellType {
            case .oneColumn :
                return OneColumnCardWithShadow.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, itemsGap: gap)
            case .twoColumn:
                return CGSize(width:0, height:0)
            case .threeColumn :
                return ThreeColumnCardWithShadow.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, itemsGap: gap, titleText: sectionsOfBook[indexPath.section].books[indexPath.item].title, subTitleText: sectionsOfBook[indexPath.section].books[indexPath.item].subTitle)
            
            }
        case .article:
            return ArticleCardWithShdow.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, text: sectionsOfArticle[indexPath.section].articles[indexPath.item].title)
        }
    }
    
    //最小cell间距
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return 1
    }
    //设置cell行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    //设置章节间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let insets = UIEdgeInsets(top: 15, left: gap, bottom: 30, right: gap)
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 100, height: 40)
        } else {
            return CGSize(width: 100, height: 40)
        }
    }
}





