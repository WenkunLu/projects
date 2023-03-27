//
//  OneCulemnCell.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/2.
//

import UIKit



//MARK: - 自定义Cell视图
class OneColumn_BookCardCell: UICollectionViewCell {

    class var reuseID: String {
        return  "OneColumn_BookCardCell"
    }
    
    var image = UIImage(named: "法兰西的陷落")
    var title: String = "书籍标题"
    var subTitle: String = "书籍作者"
    var footer: String = ""
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let footerLabel = UILabel()
    
    private let whiteView = UIView()
    
    var value: Book = Book() {
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
    
    private func setupView() {
        
        self.backgroundColor = .systemPink

        imageView.image = UIImage(named: "斑马")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 10
        whiteView.layer.cornerCurve = .continuous
        whiteView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subTitleLabel.text = subTitle
        subTitleLabel.font = .systemFont(ofSize: 14)
        subTitleLabel.alpha = 0.5
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        footerLabel.text = footer
        footerLabel.font = .systemFont(ofSize: 14)
        footerLabel.alpha = 0.5
        footerLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(imageView)
        self.addSubview(whiteView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
//        self.addSubview(footerLabel)
    
        self.layer.cornerRadius = 20
        
        
        //设置阴影颜色
        self.layer.shadowColor = UIColor.black.cgColor
        //设置透明度
        self.layer.shadowOpacity = 0.14
        //设置阴影半径
        self.layer.shadowRadius = 6
        //设置阴影偏移量
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
    }
    
    override func layoutSubviews() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            whiteView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 4),
            subTitleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -6),
        ])
        
        /*弃用
        NSLayoutConstraint.activate([
            footerLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -8),
            footerLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -6),
        ])
         */
        
    }
    
    static func recommendedCellSize(parentSafeAreaWidth width: CGFloat, itemsGap gap: CGFloat) -> CGSize {
        var size: CGSize = CGSize()
        size.width = width - gap * 2
        size.height = size.width*670/1080
        return size
    }
}









