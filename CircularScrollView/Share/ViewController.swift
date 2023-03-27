//
//  ViewController.swift
//  PanGesTest
//
//  Created by Master Lu on 2022/11/1.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIView()
    let imageView = UIImageView()
    
    var fingerLocation: CGPoint = CGPoint()
    var panGesReco = UIPanGestureRecognizer()
    var imageHeight: CGFloat = UIScreen.main.bounds.width*24076/2560
    let screenWidth: CGFloat = UIScreen.main.bounds.width

    var initialOrigin: CGPoint = .zero
    var pullDown: Int = 100
    
    var timer: DispatchSourceTimer!
    var isSuspended: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = DispatchSource.makeTimerSource(queue: .global())
        timer.activate()
        
        scrollView.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 700)
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor.systemGreen.cgColor
        scrollView.layer.masksToBounds = true
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: imageHeight)
        imageView.image = UIImage(named: "appleshop")
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
       

        panGesReco = UIPanGestureRecognizer(target: self, action: #selector(doSomeThingWhenPan))
        view.addGestureRecognizer(panGesReco)
        
        let tapGesReco = UITapGestureRecognizer(target: self, action: #selector(tapGesFunc))
        view.addGestureRecognizer(tapGesReco)
       
    }

   
    @objc func doSomeThingWhenPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialOrigin = imageView.frame.origin
            timer.cancel()
        
        //MARK: - changed
        case .changed:
            
            //滑到底部
            if imageView.frame.minY < -imageHeight + scrollView.frame.height && sender.translation(in: scrollView).y < 0 {
                imageView.frame = CGRect(x: 0,
                                         y: 0,
                                         width: screenWidth,
                                         height: imageHeight)
                initialOrigin = .zero
                
            } else {
            //滑到最上面
                if imageView.frame.minY > 0 && sender.translation(in: scrollView).y > 0 {
                    imageView.frame = CGRect(x: 0,
                                             y: -imageHeight + scrollView.frame.height,
                                             width: screenWidth,
                                             height: imageHeight)
                    initialOrigin = CGPoint(x: 0, y: -imageHeight + scrollView.frame.height)
            //在中间
                } else {
                    imageView.frame = CGRect(x: 0,
                                             y: initialOrigin.y+sender.translation(in: scrollView).y,
                                             width: screenWidth,
                                             height: imageHeight)
                }
                
            }
            
                    
        //MARK: - end
        case .ended:
            initialOrigin = imageView.frame.origin
          
            againTheTiming(y: initialOrigin.y, velocity: sender.velocity(in: scrollView).y)
            
        case .cancelled:
            print("cancled")
        default:
            break
        }
        
    }//doSomeThingWhenPan end
    
    @objc func tapGesFunc(_ sender: UITapGestureRecognizer) {
        
        
        
    }
    
    
    
    //MARK: -againTimer
    func againTheTiming(y: CGFloat, velocity: CGFloat) {
        
        var frameY: CGFloat = y
        var speed: CGFloat = velocity
        
        if !timer.isCancelled {
            if isSuspended {
                timer.resume()
            }
            timer.cancel()
        }
        
        timer = DispatchSource.makeTimerSource(queue: .global())
        timer.schedule(deadline: .now(), repeating: .milliseconds(1))

        //在此闭包内执行要计时器控制的事件
        timer.setEventHandler(handler: {
            DispatchQueue.main.async {

                //向上滚
                if velocity < 0 {
                    if speed > 0 {
                        speed = 0
                        self.timer.cancel()
                    } else {
                        speed += 4
                    }
                //向下滚
                } else {
                    if speed < 0 {
                        speed = 0
                        self.timer.cancel()
                    } else {
                        speed -= 4
                    }
                }
                frameY = frameY + speed/1000

                
                //到达底部
                if frameY < -self.imageHeight + self.scrollView.frame.height {
                    self.imageView.frame = CGRect(x: 0,
                                                  y: 0,
                                                  width: self.screenWidth,
                                                  height: self.imageHeight)
                    frameY = 0
                } else if frameY > 0 {
                //到达最上面
                    self.imageView.frame = CGRect(x: 0,
                                                  y: -self.imageHeight+self.scrollView.frame.height,
                                                  width: self.screenWidth,
                                                  height: self.imageHeight)
                    frameY = -self.imageHeight + self.scrollView.frame.height
                    print("pan end, 到最上面")
                } else {
                //中间
                    print("没有超出")
                    self.imageView.frame = CGRect(x: 0, y: frameY, width: self.screenWidth, height: self.imageHeight)
                    
                }
                
                
                //self.imageView.frame = CGRect(x: 0, y: frameY, width: self.screenWidth, height: self.imageHeight)

            }
        })
        timer.activate()
    }
}




