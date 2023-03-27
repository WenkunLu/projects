//
//  Helper.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//



import UIKit

enum EyeState {
    case stare
    case glimpse
}

enum MouthState {
    case open
    case close
}

extension UIImage {
    class func calcImageHeight(image: UIImage, width: CGFloat) -> CGFloat {
        let aspect = image.size.width / image.size.height
        return width / aspect
    }
    
    class func calcImageWidth(image: UIImage, height: CGFloat) -> CGFloat {
        let aspect = image.size.width / image.size.height
        return height * aspect
    }
}
