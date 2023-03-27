//
//  OneColumnCardWithShadow.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/16.
//

import UIKit


class OneColumnCardWithShadow: OneColumn_BookCardCell {
    override class var reuseID: String {
        return "OneColumnCardWithShadow"
    }
    
    override var value: Book {
        didSet {
            imageView.image = UIImage(named: value.widePicture)
            titleLabel.text = value.title
            if value.subTitle == "空" {
                subTitleLabel.text = "作者："+value.author
            } else {
                subTitleLabel.text = value.subTitle
            }
            footerLabel.text = value.publisher
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        //设置阴影颜色
        self.layer.shadowColor = UIColor.black.cgColor
        //设置透明度
        self.layer.shadowOpacity = 0.3
        //设置阴影半径
        self.layer.shadowRadius = 8
        //设置阴影偏移量
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
}
