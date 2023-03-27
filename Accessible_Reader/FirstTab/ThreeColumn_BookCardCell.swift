//
//  ThreeColumn_BookCardCell.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/6.
//

import UIKit



class ThreeColumn_BookCardCell: TwoColumn_BookCardCell {
        
    override class var reuseID: String {
        return "ThreeColumn_BookCardCell"
    }
    
    override var value: Book {
        didSet {
            imageView.image = UIImage(named: value.highPicture)
            titleLabel.text = value.title
            if value.subTitle == "空" {
                subtitleLabel.text = value.author
            } else {
                subtitleLabel.text = value.subTitle
            }
        }
    }
    
    override func imageViewHeightAnchorConstant() -> CGFloat {
        return 1500 * self.frame.width / 1080
    }
    
    override class func recommendedCellSize(parentSafeAreaWidth width: CGFloat, itemsGap gap: CGFloat, titleText: String, subTitleText: String) -> CGSize {
        var size = CGSize()
        
        let text = "爱丽丝梦游仙境"
        let subText = "美国迪士尼公司"
        
        let cellWidth = (width - 4 * gap)/3
        size.width = cellWidth
        
        let imageViewHeight: CGFloat = 1500/1080 * cellWidth
        
        let titleLabelHeight: CGFloat = UILabel.textHeight(width: cellWidth, font: .systemFont(ofSize: 14), text: text) + 4
        
        let subTitleHeight: CGFloat = UILabel.textHeight(width: cellWidth, font: .systemFont(ofSize: 10), text: subText) + 4

        let recommendedHeight: CGFloat = imageViewHeight + titleLabelHeight + subTitleHeight
        
        size.height = recommendedHeight

        return size
    }
}
