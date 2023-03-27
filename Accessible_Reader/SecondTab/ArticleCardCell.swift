//
//  ArticleView.swift
//  UIColl
//
//  Created by Orange on 2022/3/14.
//

import UIKit


class ArticleCardCell: UICollectionViewCell {
    
    static let reuseID: String = "ArticleCardCell"
    
    let logoImageView = UIImageView()
    let subtitleLabel = UILabel()

    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    var value: Article = Article() {
        didSet {
            logoImageView.image = UIImage(named: value.logoName)
            imageView.image = UIImage(named: value.imageName)
            titleLabel.text = value.title
            subtitleLabel.text = value.institution
        }
    }

    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    func setupView() {
        //self.layer.borderWidth = 1
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 2
        logoImageView.layer.cornerCurve = .continuous
        logoImageView.layer.masksToBounds = true
        //logoImageView.backgroundColor = .blue

        /*
         let image = UIImage(named: "timelogo")
         logoImageView.image = image
        let image2 = UIImage(named: "睡莲")
        imageView.image = image2
        subtitleLabel.text = "NationalGeographic"
        titleLabel.text = "What a huge lily pad can teach us about building design"
         */

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerCurve = .continuous
        imageView.layer.masksToBounds = true

        
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.alpha = 0.5
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        self.addSubview(logoImageView)
        self.addSubview(subtitleLabel)
        self.addSubview(titleLabel)
        self.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 22),
            logoImageView.heightAnchor.constraint(equalToConstant: 22)

        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            subtitleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10)
        ])
        
        
    }
    
    static func recommendedCellSize(parentSafeAreaWidth width: CGFloat, text: String) -> CGSize {
        var size = CGSize()

        //图片80，图片左边空10，屏幕两侧空12
        let titleLabelWidth = width - 80 - 10 - 12*2
        
        let titleLabelHeight = UILabel.textHeight(width: titleLabelWidth, font: .systemFont(ofSize: 18, weight: .semibold), text: text)
        
        //返回推荐的cell的width
        size.width = UIScreen.main.bounds.width - 12*2

        var recommendedHeight: CGFloat = titleLabelHeight + 22 + 6
        if recommendedHeight < 80 + 12 {
            recommendedHeight = 80 + 12
        } else if recommendedHeight > 200 {
            recommendedHeight = 200
        }
        size.height = recommendedHeight
        return size
    }
}
