////
////  File.swift
////  HeatMap
////
////  Created by Orange on 2022/3/16.
////  Copyright © 2022 AndrewZimmer. All rights reserved.
////
//
//import UIKit
//import ARKit
//
//class DetailViewController: UIViewController {
//    private let aRSCNController = ARSCNViewController()
//    private var n: Int = 0
//
//    let cancaView = UIView()
//
//    let backButton = UIButton(type: .custom)
//    let label = UILabel()
//
//
//    var value: String = "87" {
//        didSet {
//            label.text = value
//        }
//    }
//
//    var closure: ((_ isNavigated: Bool) -> Void)?
//
//    var eyeState = EyeState.glimpse {
//        didSet {
//            //眼睛注视状态改变了
//            if eyeState.self != oldValue {
//            }
//        }
//    }
//
//    var mouthState = MouthState.close
//
//    //DispatchSourceTimer
//    var isSusspended: Bool = true
//    var timer: DispatchSourceTimer!
//    var timeInterval: TimeInterval = TimeInterval(3) {
//        didSet {
//
//        }
//    }
//
//    //MARK: - Life Circle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //1.将ARSCNView添加给Controller
//        self.addChild(aRSCNController)
//        self.view.addSubview(aRSCNController.view)
//        aRSCNController.delegate = self
//
//        //2.将canvaView添加给Controller
//        cancaView.frame = UIScreen.main.bounds
//        if #available(iOS 15.0, *) {
//            cancaView.backgroundColor = .systemCyan
//        } else {
//            // Fallback on earlier versions
//        }
//        self.view.addSubview(cancaView)
//
//        //4. 设置返回按钮中的button样式
//        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
//        let icon = UIImage(systemName: "chevron.backward", withConfiguration: config)
//        let window = UIWindow()
//        let windowInsets = window.safeAreaInsets
//        backButton.frame = CGRect(x: 20, y: windowInsets.top, width: 100, height: 200)
//        backButton.layer.cornerCurve = .continuous
//        backButton.layer.cornerRadius = 12
//        backButton.backgroundColor = .brown
//        backButton.setImage(icon, for: .normal)
//        backButton.setTitle("返回", for: .normal)
//        backButton.tintColor = .blue
//        backButton.addTarget(self, action: #selector(leftBarButtonItemAction), for: .touchDown)
//        let barButtonTtem = UIBarButtonItem(customView: backButton)
//        self.navigationItem.leftBarButtonItem = barButtonTtem
//
//        //5.设置Controller标题
//        self.navigationItem.title = "Detail"
//
//        label.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
//
//
//        view.addSubview(label)
//        //view.addSubview(redCircle)
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//
//        self.navigationController?.navigationBar.layer.zPosition = 1
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        if let closure = closure {
//            closure(false)
//        }
//    }
//
//    @objc func leftBarButtonItemAction() {
//        self.navigationController?.popViewController(animated: true)
//    }
//}
//
//
////MARK: - ARSCNViewControllerDelegate
//extension DetailViewController: ARSCNViewControllerDelegate {
//    func traceFaceAnchor(anchor: ARAnchor) {
//        guard let faceAnchor = anchor as? ARFaceAnchor else {
//            return
//        }
//
//        for i in faceAnchor.blendShapes {
//
//            if i.key == .jawOpen {
//                if i.value.compare(0.1) == .orderedDescending  {
//                    mouthState = .open
//                } else {
//                    mouthState = .close
//                }
//            }
//        }
//
//
//    }
//
//    //MARK: - 生成lookPoint
//    func traceLookAtPoint(point: CGPoint) {
//        DispatchQueue.main.async {
//
//            if self.backButton.frame.contains(point) == true && self.mouthState == .open {
//                //self.navigationController?.popViewController(animated: true)
//            }
//        }
//
//
//    }
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
