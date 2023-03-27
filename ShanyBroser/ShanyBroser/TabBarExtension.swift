//
//  TabBarExtension.swift
//  ShanyBroser
//
//  Created by Master Lu on 2022/5/16.
//

import UIKit




extension ViewController: UITabBarDelegate {
    
    func reload() {
        webView.reload()
    }

    func goBack() {
        webView.goBack()
    }

    func goForward() {
        webView.goForward()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            goBack()
            tabBar.selectedItem = nil
        } else if item.tag == 1 {
            goForward()
            tabBar.selectedItem = nil
        } else if item.tag == 2 {
            reload()
        } else if item.tag == 3 {
            print(item.tag)
        }
    }
        
}
