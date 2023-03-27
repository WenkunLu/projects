//
//  BookCollectionController.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//



import UIKit
import SwiftUI


class BookCollectionController: BasicCollectionController {
    
    var collectionView: UICollectionView!
    let dataSource = BookDataSource()
    var readLaterDataSource = ReadLaterDataSource()
    
    //UI界面相关
    private let gap: CGFloat = 12
    
    //DataSource数据来源相关
    private var sections: [BookDataSource.SectionModel] {
        return dataSource.sections
    }
    
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //先把多重数组cells的章节填满
        for _ in sections {
            cells.append([])
        }
        
        setupCollectionView()
        
    }
  
    //MARK: - 人脸追踪
    override func performingNavigation() {
        guard isAppeared && isEyeInteractionEnabled else { return }
        DispatchQueue.main.async {
            let detailVC = BookDetailController()
            self.navigationController?.pushViewController(detailVC, animated: true)
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
    

}


//MARK: - Data Source
extension BookCollectionController: UICollectionViewDataSource {
    
    //设置章节个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    //设置每个章节中cell数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var tagCount: Int = 0
        tagCount = sections[section].books.count

        return tagCount
    }
    
    //MARK: - 添加cell，设置cell视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let oneColumnCell = collectionView.dequeueReusableCell(withReuseIdentifier: OneColumn_BookCardCell.reuseID, for: indexPath) as! OneColumn_BookCardCell
        let twoColumnCell = collectionView.dequeueReusableCell(withReuseIdentifier: TwoColumn_BookCardCell.reuseID, for: indexPath) as! TwoColumn_BookCardCell
        let threeColumnCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ThreeColumn_BookCardCell.reuseID,
            for: indexPath) as! ThreeColumn_BookCardCell
        
        
                
        switch sections[indexPath.section].cellType {
        case .oneColumn:
            oneColumnCell.value = sections[indexPath.section].books[indexPath.item]
            self.cells[indexPath.section].append(oneColumnCell)
            return oneColumnCell
            
        case .twoColumn:
            twoColumnCell.value = sections[indexPath.section].books[indexPath.item]
            self.cells[indexPath.section].append(twoColumnCell)
            return twoColumnCell
            
        case .threeColumn:
            threeColumnCell.value = sections[indexPath.section].books[indexPath.item]
            self.cells[indexPath.section].append(threeColumnCell)
            return threeColumnCell
        }
        
        
    }
    
    //设置页眉视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID, for: indexPath) as! SectionHeaderView
        header.value = sections[indexPath.section].header
        return header
    }
    
    
}


extension BookCollectionController: UICollectionViewDelegateFlowLayout {
    //MARK: - 设置cell尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = view.safeAreaInsets
        let safeAreaWidth = UIScreen.main.bounds.width - insets.left - insets.right
    
        //let screenWidth = UIScreen.main.bounds.width
        //var itemWidth: CGFloat = 0
        
        switch sections[indexPath.section].cellType {
        case .oneColumn:
            return OneColumn_BookCardCell.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, itemsGap: gap)
        case .twoColumn:
            return TwoColumn_BookCardCell.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, itemsGap: gap, titleText: sections[indexPath.section].books[indexPath.item].title, subTitleText: sections[indexPath.section].books[indexPath.item].subTitle)
        case .threeColumn:
            return ThreeColumn_BookCardCell.recommendedCellSize(parentSafeAreaWidth: safeAreaWidth, itemsGap: gap, titleText: sections[indexPath.section].books[indexPath.item].title, subTitleText: sections[indexPath.section].books[indexPath.item].subTitle)
        }
       
        
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
extension BookCollectionController: UICollectionViewDelegate, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = BookDetailController()
        vc.value = sections[indexPath.section].books[indexPath.item]
        vc.readLaterDataSource = self.readLaterDataSource
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.contentOffset = scrollView.contentOffset.y
    }
}



//MARK: - 计算文字高度
extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    //计算宽度
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)

    }
    
    //计算高度
    class func textHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        let rect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.height)
    }
}
