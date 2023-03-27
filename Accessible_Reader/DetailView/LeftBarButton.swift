//
//  LeftBarButton.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/5/1.
//

import UIKit



class LeftBarButton: UIBarButtonItem {
    
    let backButton = UIButton(type: .custom)

    override init() {
        super.init()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
                
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
        let icon = UIImage(systemName: "chevron.backward", withConfiguration: config)
        
        backButton.frame = CGRect(x: 0, y: 100, width: 100, height: 200)
        backButton.layer.cornerCurve = .continuous
        backButton.layer.cornerRadius = 8
        backButton.backgroundColor = UIColor(named: "mainLightOrange")
        backButton.setImage(icon, for: .normal)
        backButton.setTitle("返回", for: .normal)
        backButton.tintColor = .white
        
        self.customView = backButton
        
    }
   
}
