//
//  SettingViewController.swift
//  Assistive_reader
//
//  Created by Master Lu on 2022/12/9.
//

import UIKit



class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2-100, y: 400, width: 200, height: 100))
        
        label.text = "功能开发中"
        label.textAlignment = .center
        view.addSubview(label)
    }
}
