//
//  InputCell.swift
//  HowToUseCoreData
//
//  Created by Master Lu on 2023/2/17.
//

import UIKit


class InputTableViewCell: UITableViewCell {
    
    var textField: UITextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        contentView.addSubview(textField)
        textField.placeholder = "输入"
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.layer.borderWidth = 1
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}


