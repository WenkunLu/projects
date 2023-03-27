//
//  ArticleCollection.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/6/7.
//

import UIKit


class ArticleCollectionController: BasicCollectionController {

    var collectionView: UICollectionView!
    let dataSource = ArticleDataSouce()

    var readLaterDataSource = ReadLaterDataSource()

    //UI界面相关
    private let gap: CGFloat = 12

    //DataSource数据来源相关
    private var sections: [ArticleDataSouce.SectionModel] {
        return dataSource.sections
    }

    var n: Int = 0

    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        //先把多重数组cells的章节填满
        for _ in sections {
            cells.append([])
        }

    }


    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self

        //MARK: - 注册cell
        //注册cell_book
        collectionView.register(OneColumn_BookCardCell.self, forCellWithReuseIdentifier: OneColumn_BookCardCell.reuseID)
        collectionView.register(TwoColumn_BookCardCell.self, forCellWithReuseIdentifier: TwoColumn_BookCardCell.reuseID)
        collectionView.register(ThreeColumn_BookCardCell.self, forCellWithReuseIdentifier: ThreeColumn_BookCardCell.reuseID)

        //注册cell_article
        collectionView.register(ArticleCardCell.self, forCellWithReuseIdentifier: ArticleCardCell.reuseID)

        //注册页眉section_header
        collectionView.register(SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseID)

        self.view.addSubview(collectionView)

    }
    
    //MARK: - 眼动追踪
    override func performingNavigation() {
        guard isAppeared && isEyeInteractionEnabled else { return }
        DispatchQueue.main.async {
            self.n += 1
            let detailVC = ArticleDetailController()
            self.navigationController?.pushViewController(detailVC, animated: true)
            print(self.n)
        }

    }


}


//MARK: - Data Source
extension ArticleCollectionController: UICollectionViewDataSource {

    //设置章节个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    //设置每个章节中cell数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var tagCount: Int = 0

        tagCount = sections[section].articles.count

        return tagCount
    }

    //MARK: - 添加cell，设置cell视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let articleCardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ArticleCardCell.reuseID, for: indexPath) as! ArticleCardCell

        articleCardCell.value = sections[indexPath.section].articles[indexPath.item]
        
        self.cells[indexPath.section].append(articleCardCell)

        return articleCardCell
    }

    //设置页眉视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID, for: indexPath) as! SectionHeaderView
        header.value = sections[indexPath.section].header
        return header
    }


}


extension ArticleCollectionController: UICollectionViewDelegateFlowLayout {
    //MARK: - 设置cell尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let insets = view.safeAreaInsets
        let safeAreaWidth = UIScreen.main.bounds.width - insets.left - insets.right

        //let screenWidth = UIScreen.main.bounds.width
        //var itemWidth: CGFloat = 0


        return ArticleCardCell.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, text: sections[indexPath.section].articles[indexPath.item].title)
    }

    //最小cell间距
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return 1
    }

    // 最小cell行距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    //设置每个章节的上下左右边距
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {

        if insetForSectionAt == sections.count-1 {
            return UIEdgeInsets(top: 4, left: gap, bottom: 60, right: gap)
        } else {
            return UIEdgeInsets(top: 4, left: gap, bottom: 0, right: gap)
        }

    }

    //设置页眉大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 100, height: 40)
        } else {
            return CGSize(width: 100, height: 60)
        }
    }

}


//MARK: - 选中特定cell事件
extension ArticleCollectionController: UICollectionViewDelegate, UIScrollViewDelegate {

    //选中特定cell事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let vc = DetailViewController()
        //vc.value = "这是第\(indexPath.section)章\(indexPath.item)个"
        //self.navigationController?.pushViewController(vc, animated: true)

        let vc = ArticleDetailController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.contentOffset = scrollView.contentOffset.y
    }
    
    
}

