//
//  LayoutExtension.swift
//  ShanyBroser
//
//  Created by Master Lu on 2022/5/16.
//

import UIKit

extension ViewController {
    
    
    //MARK: - layoutWhenViewDidLoad
    func layoutWhenViewDidLoad() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        let keyboardGuide = view.keyboardLayoutGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(
                equalTo: backViewOfField.topAnchor,constant: 5),
            textField.leadingAnchor.constraint(
                equalTo: backViewOfField.leadingAnchor,constant: 20),
            textField.trailingAnchor.constraint(
                equalTo: backViewOfField.trailingAnchor,constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
        ])
        backViewToTabBarCon1 = backViewOfField.topAnchor.constraint(equalTo: tabBar.topAnchor)
        backViewBottom1 = backViewOfField.bottomAnchor.constraint(equalTo: keyboardGuide.topAnchor)
        backViewBottom2 = backViewOfField.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        
        NSLayoutConstraint.activate([
            backViewToTabBarCon1,
            backViewOfField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backViewOfField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backViewOfField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
                tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tabBar.heightAnchor.constraint(equalToConstant: 130)
            ])
        } else {
            NSLayoutConstraint.activate([
                tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
                tabBar.heightAnchor.constraint(equalToConstant: 144)
            ])
        }
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: keyboardGuide.topAnchor),
        ])
        
        progressBarWidthConstraint = progressBar.widthAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: backViewOfField.leadingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: backViewOfField.topAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 2),
            progressBarWidthConstraint
        ])
    }
    
    //MARK: - changeConstraintOfTextField
    func changeConstraintOfTextField(isis: Bool) {
        let keyboardGuide = view.keyboardLayoutGuide
        let safeAreaGuide = view.safeAreaLayoutGuide

        backViewOfField.constraints.forEach { cons in
            if cons.firstAttribute == .height {
                NSLayoutConstraint.deactivate([cons])
            }
        }
    
        if isis {
            NSLayoutConstraint.deactivate([
                backViewToTabBarCon1,
                backViewBottom1
            ])
            NSLayoutConstraint.activate([
                backViewOfField.topAnchor.constraint(equalTo: keyboardGuide.topAnchor, constant: -60),
                backViewOfField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                backViewOfField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
                backViewBottom2
            ])
        } else {
            NSLayoutConstraint.deactivate([
                backViewBottom2
            ])
            NSLayoutConstraint.activate([
                backViewToTabBarCon1,
                backViewOfField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backViewOfField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backViewBottom1
            ])
             
        }

    }
}
