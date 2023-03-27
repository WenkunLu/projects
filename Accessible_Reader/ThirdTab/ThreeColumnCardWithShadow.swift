//
//  TwoColumnCardWithShadow.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/16.
//

import UIKit



class ThreeColumnCardWithShadow: ThreeColumn_BookCardCell {
    override class var reuseID: String {
        return "TwoColumnCardWithShadow"
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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
