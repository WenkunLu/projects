//
//  ScrollButtonView.swift
//  Assistive_reader
//
//  Created by Master Lu on 2022/12/6.
//

import UIKit


class ScrollButtonView: UIView {
    
    let upButton: UIButton = UIButton()
    let downButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        upButton.backgroundColor = .blue
        upButton.alpha = 0.4
        
        upButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(upButton)
        self.addSubview(downButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            upButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            upButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            upButton.widthAnchor.constraint(equalToConstant: 100),
            upButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
