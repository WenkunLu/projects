//
//  BookCollectionController.swift
//  ReadAndThink
//
//  Created by Orange on 2022/3/13.
//

import UIKit


class SectionHeaderView: UICollectionReusableView {
    static let reuseID: String = "Header"
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    var value: Header = Header() {
        didSet {
            titleLabel.text = value.title
            subtitleLabel.text = value.secondTitle
        }
    }
    
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "这是一个标题"
        titleLabel.font = .systemFont(ofSize: 24)
        //titleLabel.backgroundColor = .brown
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "显示一个副标题"
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.alpha = 0.5
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
    }
    
    override func layoutSubviews() {

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            subtitleLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        ])
    }
}
