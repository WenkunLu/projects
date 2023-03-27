////
////  MovieNovelView.swift
////  ReadAndThink
////
////  Created by Master Lu on 2022/4/1.
////
//
//
//import UIKit
//
//
//class MovieNovelView: UICollectionViewCell {
//    
//    static let reuseID: String = "CellView"
//    
//    let imageView: UIImageView = UIImageView()
//    let titleLabel = UILabel()
//    let subtitleLabel = UILabel()
//    
//    var value: BookAndArticle = BookAndArticle() {
//        didSet {
//            imageView.image = UIImage(named: value.imageName)
//            titleLabel.text = value.title
//            subtitleLabel.text = value.secondTitle
//        }
//    }
//    
//    /* 测试view用
//    var bookImage: UIImage? = UIImage(named: "冰雪奇缘")
//    var text: String = "这是cell的标题"
//    var secondText: String = "这是cell的副标题显示"
//    */
//    
//    //MARK: - INIT
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    //MARK: - SETUP
//    func setupView() {
//        //self.backgroundColor = .brown
//        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .systemYellow
//        
//        titleLabel.font = .systemFont(ofSize: 14)
//        titleLabel.numberOfLines = 0
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        subtitleLabel.font = .systemFont(ofSize: 10)
//        subtitleLabel.alpha = 0.5
//        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        imageView.layer.cornerRadius = 8
//        imageView.layer.cornerCurve = .continuous
//        imageView.layer.masksToBounds = true
//
//        self.addSubview(imageView)
//        self.addSubview(titleLabel)
//        self.addSubview(subtitleLabel)
//        
//    }
//    
//    override func layoutSubviews() {
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: calcImageHeight())
//        ])
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
//        ])
//        NSLayoutConstraint.activate([
//            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
//            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            subtitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
//        ])
//    }
//    
//    func calcImageHeight() -> CGFloat {
//        guard let image = imageView.image else {
//            return 0
//        }
//        let aspect = image.size.width / image.size.height
//        return self.bounds.width / aspect
//    }
//
//}
//
//
//
//
