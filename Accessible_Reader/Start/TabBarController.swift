//
//  TabBarController.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//

import UIKit



class TabBarController: UITabBarController {
    
    //四个tab页面
    let firstCV = BookCollectionController()
    let secondCV = ArticleCollectionController()
    let thirdCV = ReadLaterViewController()
    let fourthCV = SettingViewController()
    
    let upButton: UIButton = UIButton()
    let downButton: UIButton = UIButton()
        
    //收藏功能接入点
    let readLater = ReadLaterDataSource()
  
    //tabBar眼动控制
    var redCircle : UIView = UIView()
    let barItemSpacing: CGFloat = 30
    var barItemWidth: CGFloat {
        return (UIScreen.main.bounds.width-barItemSpacing*3)/4
    }
    
    let notificationCenter = NotificationCenter.default
    
    //控制视图是否能被交互
    var isAppeared: Bool = false
    var isEyeInteractionEnabled: Bool = true
    
    //眼动追踪两个条件
    var isReached:Int = 0 {
        didSet {
            if isContained {
                switch itemNumberSeen {
                case 0:
                    selectedIndex = 0
                case 1:
                    selectedIndex = 1
                case 2:
                    selectedIndex = 2
                case 3:
                    selectedIndex = 3
                default:
                    break
                }
            }
            
            if isScrollButtonContained {
                switch itemNumberSeen {
                case 4:
                    scrollUp()
                case 5:
                    scrollDown()
                default:
                    break
                }
            }
        }
    }
    
    var isContained: Bool = false
    var isScrollButtonContained: Bool = false
    var itemNumberSeen: Int = 0

    //滚动按钮
    var firstCVOffset: CGFloat = 0
    //MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        firstCV.readLaterDataSource = readLater
        thirdCV.readLaterDataSource = readLater
                        
        let image1 = UIImage(systemName: "books.vertical.fill")
        let image2 = UIImage(systemName: "text.redaction")
        let image3 = UIImage(systemName: "star.leadinghalf.filled")
        let image4 = UIImage(systemName: "gearshape.fill")

        firstCV.tabBarItem = UITabBarItem(title: "发现好书", image: image1, tag: 0)
        secondCV.tabBarItem = UITabBarItem(title: "今日热文", image: image2, tag: 2)
        thirdCV.tabBarItem = UITabBarItem(title: "稍后阅读", image: image3, tag: 3)
        fourthCV.tabBarItem = UITabBarItem(title: "设置", image: image4, tag: 4)

        self.setViewControllers([firstCV, secondCV, thirdCV, fourthCV], animated: true)
        self.selectedIndex = 1
        
        self.navigationController?.isNavigationBarHidden = true
        
        //3. 添加光标
        redCircle.backgroundColor = UIColor.red
        redCircle.frame = CGRect.init(x: 100,y:100 ,width: 40 ,height: 40)
        redCircle.alpha = 0.8
        redCircle.layer.cornerRadius = 20
        view.addSubview(redCircle)
        
        upButton.backgroundColor = .blue
        upButton.alpha = 0.4
        upButton.frame = CGRect(x: 240, y: 160, width: 100, height: 100)
        view.addSubview(upButton)
        
        downButton.backgroundColor = .blue
        downButton.alpha = 0.4
        downButton.frame = CGRect(x: 240, y: 560, width: 100, height: 100)
        view.addSubview(downButton)
        
        
        let notificationNameisReached = Notification.Name("isReached")
        let notificationNamelookAtPoint = Notification.Name("lookAtPoint")
        notificationCenter.addObserver(self, selector: #selector(whetherThresholdIsReached), name: notificationNameisReached, object: nil)
        notificationCenter.addObserver(self, selector: #selector(traceLookAtPoint), name: notificationNamelookAtPoint, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = barItemSpacing
        tabBar.itemWidth = (UIScreen.main.bounds.width-barItemSpacing*3)/4
        
        let inset = view.safeAreaInsets.bottom
        firstCV.heightOfTabBar = tabBar.frame.height + inset + 30
        secondCV.heightOfTabBar = tabBar.frame.height + inset + 30
        thirdCV.heightOfTabBar = tabBar.frame.height + inset + 30
        
        isAppeared = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        isAppeared = false
    }
    

    //MARK: - 眼动追踪
    @objc func whetherThresholdIsReached(_ notification: NSNotification) {
        if let message = notification.userInfo?["isReached"] as? Int {
            self.isReached = message
        }
    }
    
    @objc func traceLookAtPoint(_ notification: NSNotification) {
        //只有视图出现的才能眼动控制
        guard isAppeared else { return }
    
        if let point = notification.userInfo?["lookAtPoint"] as? CGPoint {
            DispatchQueue.main.async {
                self.redCircle.center = point

                //滚动按钮
                let upButtonFrame = CGRect(x: 240, y: 160, width: 100, height: 100)
                let downButtonFrame = CGRect(x: 240, y: 560, width: 100, height: 100)
                
                if upButtonFrame.contains(point) {
                    self.isScrollButtonContained = true
                    self.firstCV.isEyeInteractionEnabled = false
                    self.secondCV.isEyeInteractionEnabled = false
                    self.thirdCV.isEyeInteractionEnabled = false
                    self.itemNumberSeen = 4

                } else if downButtonFrame.contains(point) {
                    self.isScrollButtonContained = true
                    self.firstCV.isEyeInteractionEnabled = false
                    self.secondCV.isEyeInteractionEnabled = false
                    self.thirdCV.isEyeInteractionEnabled = false
                    self.itemNumberSeen = 5

                } else {
                    self.isScrollButtonContained = false
                    self.firstCV.isEyeInteractionEnabled = true
                    self.secondCV.isEyeInteractionEnabled = true
                    self.thirdCV.isEyeInteractionEnabled = true
                    self.itemNumberSeen = 10
                }
                
                
                //tabBar
                let firstItemFrame = CGRect(
                    x: 0,
                    y: UIScreen.main.bounds.height-self.tabBar.frame.height,
                    width: self.barItemWidth,
                    height: self.tabBar.frame.height)
                
                let secondItemFrame = CGRect(
                    x: self.barItemWidth*1 + self.barItemSpacing*1,
                    y: UIScreen.main.bounds.height-self.tabBar.frame.height,
                    width: self.barItemWidth,
                    height: self.tabBar.frame.height)
                
                let thirdItemFrame = CGRect(
                    x: self.barItemWidth*2 + self.barItemSpacing*2,
                    y: UIScreen.main.bounds.height-self.tabBar.frame.height,
                    width: self.barItemWidth,
                    height: self.tabBar.frame.height)
                
                let fourthItemFrame = CGRect(
                    x: self.barItemWidth*3 + self.barItemSpacing*3,
                    y: UIScreen.main.bounds.height-self.tabBar.frame.height,
                    width: self.barItemWidth,
                    height: self.tabBar.frame.height)
                
                //MARK: - 点击tabBar项目
                if firstItemFrame.contains(point) {
                    self.redCircle.backgroundColor = .yellow
                    self.itemNumberSeen = 0
                    self.isContained = true
                    
                } else if secondItemFrame.contains(point) {
                    self.redCircle.backgroundColor = .yellow
                    self.itemNumberSeen = 1
                    self.isContained = true

                } else if thirdItemFrame.contains(point) {
                    self.redCircle.backgroundColor = .yellow
                    self.itemNumberSeen = 2
                    self.isContained = true

                } else if fourthItemFrame.contains(point) {
                    self.redCircle.backgroundColor = .yellow
                    self.itemNumberSeen = 3
                    self.isContained = true

                } else {
                    self.redCircle.backgroundColor = .red
                    self.isContained = false
                }
                
                
                
            }
        }
    
    
    }
}

 
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
    
  
    
    func scrollUp() {
        if firstCVOffset > firstCV.collectionView.contentSize.height - UIScreen.main.bounds.height {
            firstCVOffset = firstCV.collectionView.contentSize.height - UIScreen.main.bounds.height
            return
        } else {
            firstCVOffset += 100
        }
        
        
        firstCV.collectionView.setContentOffset(CGPoint(x: 0, y: firstCVOffset), animated: true)
    }
    
    func scrollDown() {
        if firstCVOffset < 0 {
            firstCVOffset = 0
            return
        } else {
            firstCVOffset -= 100
        }
        
        firstCV.collectionView.setContentOffset(CGPoint(x: 0, y: firstCVOffset), animated: true)
    }
}






