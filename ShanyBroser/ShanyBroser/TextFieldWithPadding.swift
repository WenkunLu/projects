//
//  TextFieldWithPadding.swift
//  ShanyBroser
//
//  Created by Master Lu on 2022/5/16.
//

import UIKit




class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 2,
        bottom: 0,
        right: 0
    )
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return CGRect(x: rect.minX+6, y: rect.minY, width: rect.width, height: rect.height)
    }
}

