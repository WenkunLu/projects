//
//  SetupExtension.swift
//  ShanyBroser
//
//  Created by Master Lu on 2022/5/17.
//

import UIKit




extension ViewController {
    
    
    
    func setupTabBar() {
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        
        let image1 = UIImage(systemName: "chevron.left")
        let image2 = UIImage(systemName: "chevron.right")
        let image3 = UIImage(systemName: "arrow.counterclockwise")
        let image4 = UIImage(systemName: "ellipsis")
        
        firstItem = UITabBarItem(title: "", image: image1, tag: 0)
        secondItem = UITabBarItem(title: "", image: image2, tag: 1)
        let thirdItem = UITabBarItem(title: "", image: image3, tag: 2)
        let fourthItem = UITabBarItem(title: "", image: image4, tag: 3)
        
        tabBar.setItems([firstItem, secondItem, thirdItem, fourthItem], animated: true)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.selectedItem = fourthItem
        
        let itemAppearence = UITabBarItemAppearance(style: .stacked)
        itemAppearence.normal.iconColor = .tintColor
        itemAppearence.selected.iconColor = .tintColor
        itemAppearence.focused.iconColor = .systemGray
        itemAppearence.disabled.iconColor = .tintColor
        
        barAppearance.stackedLayoutAppearance = itemAppearence
        barAppearance.inlineLayoutAppearance = itemAppearence
        barAppearance.compactInlineLayoutAppearance = itemAppearence
    }
    
    
    func setupField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerCurve = .continuous
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .white
        textField.delegate = self
        textField.placeholder = "搜索或输入网站名称"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        let iconConf = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular, scale: .medium)
        let iconImage = UIImage(systemName: "magnifyingglass", withConfiguration: iconConf)
        let imageView = UIImageView(image: iconImage)
        imageView.tintColor = .gray
        imageView.alpha = 0.4
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        leftView = imageView
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        backViewOfField.translatesAutoresizingMaskIntoConstraints = false
        backViewOfField.backgroundColor = .clear
        backViewOfField.addSubview(textField)
        
        backViewOfField.layer.shadowColor = UIColor.black.cgColor
        backViewOfField.layer.shadowRadius = 8
        backViewOfField.layer.shadowOpacity = 0.1
        backViewOfField.layer.shadowOffset = CGSize(width: 0, height: 1)
         
    }
}

