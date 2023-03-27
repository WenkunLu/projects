//
//  ReadingInterfaceViewController.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/29.
//

import UIKit


class ReadingInterfaceController: UIViewController {
    
    let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let leftButton = LeftBarButton()
        self.navigationItem.leftBarButtonItem = leftButton
        leftButton.backButton.addTarget(self, action: #selector(leftBarButtonItemAction), for: .touchDown)
        
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
    }

    @objc func leftBarButtonItemAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
