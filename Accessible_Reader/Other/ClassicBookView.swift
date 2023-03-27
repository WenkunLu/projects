////
////  ClassicBookView.swift
////  UIColl
////
////  Created by Orange on 2022/3/14.
////
//
//import UIKit
//
//
//class ClassicBookView: UICollectionViewCell {
//    static let reuseID: String = "ClassicBookView"
//    
//    let imageView: UIImageView = UIImageView()
//    let titleLabel: UILabel = UILabel()
//    let subtitleLabel: UILabel = UILabel()
//    
//    var value: BookAndArticle = BookAndArticle() {
//        didSet {
//            imageView.image = UIImage(named: value.imageName)
//            titleLabel.text = value.title
//            subtitleLabel.text = value.secondTitle
//        }
//    }
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
//    func setupView() {
//        //self.backgroundColor = .cyan
//        //self.layer.borderWidth = 1
//                
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = 8
//        imageView.layer.cornerCurve = .continuous
//        imageView.layer.masksToBounds = true
//        
//        titleLabel.font = .systemFont(ofSize: 14)
//        
//        subtitleLabel.font = .systemFont(ofSize: 10)
//        subtitleLabel.alpha = 0.5
//        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.addSubview(imageView)
//        self.addSubview(titleLabel)
//        self.addSubview(subtitleLabel)
//
//    }
//    
//    override func layoutSubviews() {
//        
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
//         
//    }
//    
//    func calcImageHeight() -> CGFloat {
//        guard let image = imageView.image else {
//            return 0
//        }
//        let aspect = image.size.width / image.size.height
//        return self.frame.width / aspect
//    }
//}
