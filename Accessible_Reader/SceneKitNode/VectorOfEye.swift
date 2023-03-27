//
//  VectorOfEye.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//

import UIKit
import ARKit
import SceneKit

class VectorOfEye: SCNNode {
    let vectorLength:Float = 1
    
    let leftEye: SCNNode
    let rightEye: SCNNode
    
    let leftEyeEnd : SCNNode
    let rightEyeEnd : SCNNode
    
    override init() {
        leftEye = SCNNode()
        rightEye = SCNNode()
        
        leftEye.opacity = 0.5
        rightEye.opacity = 0
        
        leftEyeEnd = SCNNode()
        leftEye.addChildNode(leftEyeEnd)
        leftEyeEnd.simdPosition = simd_float3(0, 0, vectorLength)
        
        rightEyeEnd = SCNNode()
        rightEye.addChildNode(rightEyeEnd)
        rightEyeEnd.simdPosition = simd_float3(0, 0, vectorLength)
        
        super.init()
        
        addChildNode(leftEye)
        addChildNode(rightEye)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        if #available(iOS 13.0, *) {
            leftEye.simdTransform = anchor.leftEyeTransform
            rightEye.simdTransform = anchor.rightEyeTransform
        } else {
            
        }
    }
}
