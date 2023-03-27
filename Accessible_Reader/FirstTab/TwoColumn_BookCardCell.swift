//
//  TwoColumn_BookCardCell.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/4.
//

import UIKit





class TwoColumn_BookCardCell: UICollectionViewCell {
    
    class var reuseID: String {
        return  "TwoColumn_BookCardCell"
    }
    
    let imageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let whiteView: UIView = UIView()
    
    var value: Book = Book() {
        didSet {
            imageView.image = UIImage(named: value.widePicture)
            titleLabel.text = value.title
            if value.subTitle == "空" {
                subtitleLabel.text = "作者："+value.author
            } else {
                subtitleLabel.text = value.subTitle
            }
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
        //self.backgroundColor = .cyan
        //self.layer.borderWidth = 1
        
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 10
        whiteView.layer.cornerCurve = .continuous
        whiteView.translatesAutoresizingMaskIntoConstraints = false
                
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerCurve = .continuous
        imageView.layer.masksToBounds = true
        let image = UIImage(named: value.highPicture)
        imageView.image = image
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.text = "标题"
        
        subtitleLabel.font = .systemFont(ofSize: 10)
        subtitleLabel.alpha = 0.5
        subtitleLabel.text = "SubTitle"
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(whiteView)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)

    }
    
    override func layoutSubviews() {
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: self.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeightAnchorConstant())
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subtitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
         
    }
    
    
    func imageViewHeightAnchorConstant() -> CGFloat {
        return 670/1080 * self.frame.width
    }
    
    //MARK: - 返回cell大小
    class func recommendedCellSize(parentSafeAreaWidth width: CGFloat, itemsGap gap: CGFloat,  titleText: String, subTitleText: String) -> CGSize {
        var size = CGSize()
        
        let text = "爱丽丝梦游仙境"
        let subText = "美国迪士尼公司"
        
        let cellWidth = (width - 3 * gap)/2
        size.width = cellWidth
        
        let imageViewHeight: CGFloat = 700/1080 * cellWidth
        
        let titleLabelHeight: CGFloat = UILabel.textHeight(width: cellWidth, font: .systemFont(ofSize: 14), text: text) + 4
        
        let subTitleHeight: CGFloat = UILabel.textHeight(width: cellWidth, font: .systemFont(ofSize: 10), text: subText) + 4

        let recommendedHeight: CGFloat = imageViewHeight + titleLabelHeight + subTitleHeight
        
        size.height = recommendedHeight

        return size
    }
    
}




