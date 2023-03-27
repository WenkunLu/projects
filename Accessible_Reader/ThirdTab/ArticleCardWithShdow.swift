//
//  ArticleCardWithShdow.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/2.
//

import UIKit



class ArticleCardWithShdow: UICollectionViewCell {
    static let reuseID: String = "ArticleCardWithShdow"
    
    var image = UIImage(named: "testimage")
    var logoImage = UIImage(named: "testlogo")
    var title: String = "Return to the Office? Not in This Housing Market. Return to the Office? Not in This Housing Market"
    var subTitle: String = "文章来源"
    
    var value: Article = Article() {
        didSet {
            logoImageView.image = UIImage(named: value.logoName)
            imageView.image = UIImage(named: value.imageName)
            titleLabel.text = value.title
            subTitleLabel.text = value.institution
        }
    }
    
    let logoImageView = UIImageView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    private let whiteBackguound = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - setupView
    func setupView() {
        //self.backgroundColor = .systemGreen
        whiteBackguound.backgroundColor = .white
        whiteBackguound.layer.cornerCurve = .continuous
        whiteBackguound.layer.cornerRadius = 10
        whiteBackguound.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerCurve = .continuous
        logoImageView.layer.cornerRadius = 4
        logoImageView.layer.masksToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        subTitleLabel.text = subTitle
        subTitleLabel.font = .systemFont(ofSize: 12)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.numberOfLines = 0
        //titleLabel.backgroundColor = .cyan
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(whiteBackguound)
        self.addSubview(logoImageView)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        //设置阴影颜色
        self.layer.shadowColor = UIColor.black.cgColor
        //设置透明度
        self.layer.shadowOpacity = 0.2
        //设置阴影半径
        self.layer.shadowRadius = 6
        //设置阴影偏移量
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
    }
    
    
    //MARK: - Layout Views
    override func layoutSubviews() {
        
        NSLayoutConstraint.activate([
            whiteBackguound.topAnchor.constraint(equalTo: self.topAnchor),
            whiteBackguound.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            whiteBackguound.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            whiteBackguound.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            logoImageView.widthAnchor.constraint(equalToConstant: 22),
            logoImageView.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            subTitleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
    }
    
    //MARK: - 返回cell自身需要的大小
    
    
    static func recommendedCellSize(parentSafeAreaWidth width: CGFloat, text: String) -> CGSize {
        var size = CGSize()

        //图片80，图片左边空10，屏幕两侧空12, label两侧空8，图片右侧空10
        let titleLabelWidth = width - 80 - 12*2 - 8 - 8 - 10
        
        let titleLabelHeight = UILabel.textHeight(width: titleLabelWidth, font: .systemFont(ofSize: 18, weight: .semibold), text: text)
        
        //返回推荐的cell的width
        size.width = width - 12*2

        var recommendedHeight: CGFloat = titleLabelHeight + 22 + 8 + 8 + 8
        if recommendedHeight < 80 + 10 + 10 {
            recommendedHeight = 80 + 10 + 10
        }
        size.height = recommendedHeight
        return size
    }
}













