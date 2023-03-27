//
//  BookDetailController.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/27.
//

import UIKit




class BookDetailController: BasicDetailViewController {
    
    //data
    var readLaterDataSource = ReadLaterDataSource()
    
    //视图
    private let bookDescriptionViewController = BookDescriptionViewController()
    private var containerView = UIView()
    private let appearance = UINavigationBarAppearance()
    private let buyLabel = UILabel()
    private let tabBar = UITabBar()


    private var firstItem: UITabBarItem = UITabBarItem()
    private var secondItem: UITabBarItem = UITabBarItem()
    private var thirdItem: UITabBarItem = UITabBarItem()
    
    let barItemSpacing: CGFloat = 30
    var barItemWidth: CGFloat {
        return (UIScreen.main.bounds.width-barItemSpacing*2)/4
    }

    private var timer: DispatchSourceTimer!

    private var isSuspended: Bool = true
    
    var value: Book = Book() {
        didSet {
            bookDescriptionViewController.value = value
        }
    }
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftButton = LeftBarButton()
        self.navigationItem.leftBarButtonItem = leftButton
        leftButton.backButton.addTarget(self, action: #selector(leftBarButtonItemAction), for: .touchDown)

        //self.title = "书籍"
        tabBar.delegate = self
        
        let image1 = UIImage(systemName: "text.redaction")
        let image2 = UIImage(systemName: "book.fill")
        let image3 = UIImage(systemName: "books.vertical")
            
        firstItem = UITabBarItem(title: "简介", image: image1, tag: 0)
        secondItem = UITabBarItem(title: "开始阅读", image: image2, tag: 1)
        thirdItem = UITabBarItem(title: "加入书架", image: image3, tag: 2)
        
        tabBar.setItems([firstItem, secondItem, thirdItem], animated: true)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.selectedItem = firstItem
        tabBar.layer.zPosition = 2
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = barItemSpacing
        tabBar.itemWidth = barItemWidth
        
        containerView = bookDescriptionViewController.view
        //containerView.backgroundColor = .systemYellow
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        buyLabel.translatesAutoresizingMaskIntoConstraints = false
        buyLabel.text = "已经加入书架"
        buyLabel.backgroundColor = .gray
        buyLabel.textAlignment = .center
        buyLabel.layer.cornerCurve = .continuous
        buyLabel.layer.cornerRadius = 10
        buyLabel.layer.masksToBounds = true
        buyLabel.font = .preferredFont(forTextStyle: .headline)
        buyLabel.textColor = .white
        buyLabel.isHidden = true
        buyLabel.layer.zPosition = 10
        
        self.addChild(bookDescriptionViewController)
        
        view.addSubview(containerView)
        view.addSubview(tabBar)
        view.addSubview(buyLabel)
        
        layout()
        
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -84),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyLabel.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20),
            buyLabel.widthAnchor.constraint(equalToConstant: 150),
            buyLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        
        timer = DispatchSource.makeTimerSource(queue: .global())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBar.selectedItem = firstItem
        
    }
    
    //MARK: - 眼动追踪
    override func performingNavigation() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func layout() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            containerView.widthAnchor.constraint(equalTo: guide.widthAnchor)
        ])
    }
    
    @objc func leftBarButtonItemAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        if isSuspended {
            timer.resume()
            timer.cancel()
        }
    }
    
}



//MARK: - TabBar delgate 点击TabBar
extension BookDetailController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 0 {
            containerView.removeFromSuperview()
            containerView = bookDescriptionViewController.view
            containerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(containerView)
            layout()
            
        } else if item.tag == 1 {
            let vc = ReadingInterfaceController()
            navigationController?.pushViewController(vc, animated: false)
            
        } else if item.tag == 2 {
                        
            buyLabel.isHidden = false
            tabBar.selectedItem = thirdItem
            againTheTiming()

            readLaterDataSource.addToBookshelf(value: &value)
        }
        
    }
    
    
    func againTheTiming() {
        if !timer.isCancelled {
            if isSuspended {
                self.timer.resume()
            }
            self.timer.cancel()
        }
        timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now()+1, repeating: .never)
        timer.setEventHandler(handler: {
            DispatchQueue.main.async {
                //需要延时操作
                self.buyLabel.isHidden = true
                self.tabBar.selectedItem = self.firstItem
                self.isSuspended = true
                self.timer.suspend()
            }

        })
        
        timer.activate()
        isSuspended = false
    }
     
}
