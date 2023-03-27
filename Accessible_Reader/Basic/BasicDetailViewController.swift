//
//  BasicViewController.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/12/3.
//

import UIKit


class BasicDetailViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    let redCircle = UIView()
    
    //控制视图是否能被交互
    var isAppeared: Bool = false
    var isEyeInteractionEnabled: Bool = true
    
    //眼动追踪两个条件
    var isReached:Int = 0 {
        didSet {
            if isContained {
                performingNavigation()
            }
        }
    }
    var isContained: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3. 添加光标
        redCircle.backgroundColor = UIColor.red
        redCircle.frame = CGRect.init(x: 100,y:100 ,width: 40 ,height: 40)
        redCircle.alpha = 0.8
        redCircle.layer.cornerRadius = 20

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //添加光标
        self.navigationController?.view.addSubview(redCircle)
        self.navigationController?.navigationBar.layer.zPosition = 1
        redCircle.layer.zPosition = 2

        //注册面部信息通知
        let notificationNameisReached = Notification.Name("isReached")
        let notificationNamelookAtPoint = Notification.Name("lookAtPoint")
        notificationCenter.addObserver(self, selector: #selector(whetherThresholdIsReached), name: notificationNameisReached, object: nil)
        notificationCenter.addObserver(self, selector: #selector(traceLookAtPoint), name: notificationNamelookAtPoint, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        notificationCenter.removeObserver(self)
        redCircle.removeFromSuperview()
    }
    
    //MARK: - 眼动追踪基础函数
    @objc func whetherThresholdIsReached(_ notification: NSNotification) {
        if let message = notification.userInfo?["isReached"] as? Int {
            self.isReached = message
        }
    }
    
    @objc func traceLookAtPoint(_ notification: NSNotification) {
        if let point = notification.userInfo?["lookAtPoint"] as? CGPoint {
            DispatchQueue.main.async {
                self.redCircle.center = point
                
                //有navigationBar
                if let navigationBarFrame = self.navigationController?.navigationBar.frame as? CGRect {
                    
                    //返回按钮
                    let backButtonFrame = CGRect(x: 0, y: 0, width: 100+20, height: 44+navigationBarFrame.minY)
                    if backButtonFrame.contains(point) {
                        self.redCircle.backgroundColor = .yellow
                        self.isContained = true
                    }else {
                        self.redCircle.backgroundColor = .red
                        self.isContained = false
                    }
                }
                
            }
            
        }
    }
    
    func performingNavigation() {
        
    }
}
