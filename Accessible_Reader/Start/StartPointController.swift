//
//  StartPointController.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//

import UIKit
import ARKit


class StartPointController: UIViewController {
    private let notificationCenter = NotificationCenter.default
    private var blendShapeValue: CGFloat = 0 {
        didSet {
            if oldValue < 0.2 && blendShapeValue >= 0.2 {
                postBlendShapeNotification()
            }
        }
    }
    
    //是否产生一个表情变化，产生一次值改变一次，广播一次
    private var isReached: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundController = ARSCNViewController()
        backgroundController.delegate = self
        
        let rootVC = TabBarController()
        let navigationVC = UINavigationController(rootViewController: rootVC)
        
        //把眼动追踪视图藏在navigationController后面
        self.addChild(backgroundController)
        self.addChild(navigationVC)
        
        self.view.addSubview(backgroundController.view)
        self.view.addSubview(navigationVC.view)
    
    }

}


extension StartPointController: ARSCNViewControllerDelegate {
    //MARK: - ARSCN delegate
    func traceFaceAnchor(value: CGFloat) {
        self.blendShapeValue = value
    }
    func traceLookAtPoint(point: CGPoint) {
       postLookAtPointNotification(point: point)
    }
    
    
    //发送通知
    func postBlendShapeNotification() {
        DispatchQueue.main.async {
            self.isReached += 1
            let notificationName = Notification.Name("isReached")
            let myMessage:[String: Int] = ["isReached": self.isReached]
            self.notificationCenter.post(name: notificationName, object: nil, userInfo: myMessage)
        }
    }
    func postLookAtPointNotification(point: CGPoint) {
        DispatchQueue.main.async {
            let notificationName = Notification.Name("lookAtPoint")
            let myMessage:[String: CGPoint] = ["lookAtPoint": point]
            self.notificationCenter.post(name: notificationName, object: nil, userInfo: myMessage)
        }
    }
}








/*
import SwiftUI

struct MainViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc =  StartPointController()
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    typealias UIViewControllerType = UIViewController
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainViewControllerRepresentable()
    }
}
*/
