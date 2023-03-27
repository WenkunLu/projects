//
//  BasicCollectionController.swift
//  Assistive_reader
//
//  Created by Master Lu on 2022/12/6.
//

import UIKit



class BasicCollectionController: UIViewController {
    
    let notificationCenter = NotificationCenter.default
    
    //控制视图是否能被交互
    var isAppeared: Bool = false
    var isEyeInteractionEnabled: Bool = true
    
    //眼动追踪两个条件
    var isReached:Int = 0 {
        didSet {
            for i in isContained {
                if i == true {
                    performingNavigation()
                }
            }
        }
    }
    var isContained: [Bool] = []
    
    var heightOfTabBar: CGFloat = 0
    var contentOffset: CGFloat = 0

    var detailVC: BasicDetailViewController!
    var cells:[[UICollectionViewCell]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationNameisReached = Notification.Name("isReached")
        let notificationNamelookAtPoint = Notification.Name("lookAtPoint")
        
        notificationCenter.addObserver(self, selector: #selector(whetherThresholdIsReached), name: notificationNameisReached, object: nil)
        notificationCenter.addObserver(self, selector: #selector(traceLookAtPoint), name: notificationNamelookAtPoint, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAppeared = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isAppeared = false
    }
    
    @objc
    private func whetherThresholdIsReached(_ notification: NSNotification) {
        if let message = notification.userInfo?["isReached"] as? Int {
            self.isReached = message
        }
    }
    
    @objc
    private func traceLookAtPoint(_ notification: NSNotification) {
        if let message = notification.userInfo?["lookAtPoint"] as? CGPoint {
            determineWhetherCellsContainThePoint(point: message)
        }
    }
    
    
    //判断是否包含点
    func determineWhetherCellsContainThePoint(point: CGPoint) {
        DispatchQueue.main.async {
            self.isContained = []
            
            for (_, section) in self.cells.enumerated() {
                for (_, item) in section.enumerated() {
                    
                    if point.y < UIScreen.main.bounds.height - self.heightOfTabBar {
                        let itemFrame = CGRect(
                            x: item.frame.minX,
                            y: item.frame.minY - self.contentOffset,
                            width: item.frame.width,
                            height: item.frame.height)
                        
                        if itemFrame.contains(point) {
                            self.isContained.append(true)
                            if self.isAppeared && self.isEyeInteractionEnabled {
                                item.layer.borderWidth = 1
                            } else {
                                item.layer.borderWidth = 0
                            }
                        } else {
                            self.isContained.append(false)
                            item.layer.borderWidth = 0
                        }
                    }
                    else { //矩形边界判断
                        self.isContained = []
                        item.layer.borderWidth = 0
                    }
                    
                    
                }
            }
        }//DispatchQueue.main.async
        
        
        
        
    }//func end
    
    
    func performingNavigation() {
        
    }
    
    
}//class
