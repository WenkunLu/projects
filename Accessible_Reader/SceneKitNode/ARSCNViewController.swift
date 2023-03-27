//
//  ARSCNViewController.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//


import UIKit
import SceneKit
import ARKit


protocol ARSCNViewControllerDelegate {
//    func whetherThresholdIsReached(isReached: Bool)
    func traceFaceAnchor(value: CGFloat)
    func traceLookAtPoint(point: CGPoint)
}


class ARSCNViewController: UIViewController {

    var sceneView: ARSCNView!
    var delegate: ARSCNViewControllerDelegate?
    
    var positions: Array<simd_float2> = Array()
    let numPositions = 10
    
    var vectorOfEye: VectorOfEye?
    var eyeDirection: EyeDirection?
    
    var virtualPhoneNode: SCNNode = SCNNode()
    var virtualScreenNode: SCNNode = {
        let screenGeometry = SCNPlane(width: 1, height: 1)
        screenGeometry.firstMaterial?.isDoubleSided = true
        screenGeometry.firstMaterial?.diffuse.contents = UIColor.green
        return SCNNode(geometry: screenGeometry)
    }()

    var isRuning: Bool = false
        
    //MARK: - CONTROLLER Life Circle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: self.view.frame)
        
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.showsStatistics = true
        
        vectorOfEye = VectorOfEye()
        eyeDirection = EyeDirection()
        
        virtualPhoneNode.geometry?.firstMaterial?.isDoubleSided = true
        virtualPhoneNode.addChildNode(virtualScreenNode)
        sceneView.scene.rootNode.addChildNode(vectorOfEye!)
        sceneView.scene.rootNode.addChildNode(eyeDirection!)
        sceneView.scene.rootNode.addChildNode(virtualPhoneNode)
        
        self.view.addSubview(sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
}


//MARK: - EXTENSION
extension ARSCNViewController: ARSCNViewDelegate {
    
    //配置ARSession，开始运行
    internal func setupSession() {
        if ARConfiguration.isSupported == true {
            let configuration = ARFaceTrackingConfiguration()
            sceneView.session.run(configuration)
            self.isRuning = true
        } else {
            return
        }
    }
    
    //lookAtPoint 坐标计算
    private func lookAtPointFromHittest(_ result1: SCNHitTestResult, secondResult result2: SCNHitTestResult) -> simd_float2 {
        let iPhoneXPointSize = simd_float2(390, 844)
        let iPhoneXMeterSize = simd_float2(0.0647446, 0.140115)

        let xLC = ((result1.localCoordinates.x + result2.localCoordinates.x) / 2.0)
        var x = xLC / (iPhoneXMeterSize.x / 2.0) * iPhoneXPointSize.x + 130
        
        let yLC = -((result1.localCoordinates.y + result2.localCoordinates.y) / 2.0)
        var y = yLC / (iPhoneXMeterSize.y / 2.0) * iPhoneXPointSize.y + 300
                
        x = Float.maximum(Float.minimum(x, iPhoneXPointSize.x-1), 0)
        y = Float.maximum(Float.minimum(y, iPhoneXPointSize.y-1), 0)

        positions.append(simd_float2(x,y))
        if positions.count > numPositions {
            positions.removeFirst()
        }
        
        var total = simd_float2(0,0)
        for pos in positions {
            total.x += pos.x
            total.y += pos.y
        }
        
        total.x /= Float(positions.count)
        total.y /= Float(positions.count)
        return total
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else { return nil }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }
    
    //MARK: - 生成blendShaps
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
              let nodeGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        nodeGeometry.update(from: faceAnchor.geometry)
        vectorOfEye?.transform = node.transform
        eyeDirection?.transform = node.transform
        vectorOfEye?.update(withFaceAnchor: faceAnchor)
        eyeDirection?.update(withFaceAnchor: faceAnchor)
        
        //将是否达到表情系数传给代理
        DispatchQueue.global().async {
            
            for blendShape in faceAnchor.blendShapes {
                if blendShape.key == .jawOpen {
                    self.delegate?.traceFaceAnchor(value: CGFloat(truncating: blendShape.value))

                    /*这个是判断是否超过某个表情系数值
                    if blendShape.value.compare(0.2) == .orderedDescending  {
                        self.delegate?.whetherThresholdIsReached(isReached: true)
                    } else {
                        self.delegate?.whetherThresholdIsReached(isReached: false)
                    }
                     */
                    
                }
            }
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        virtualPhoneNode.transform = (sceneView.pointOfView?.transform)!
        
        let options : [String: Any] = [SCNHitTestOption.backFaceCulling.rawValue: false,
                                       SCNHitTestOption.searchMode.rawValue: 1,
                                       SCNHitTestOption.ignoreChildNodes.rawValue : false,
                                       SCNHitTestOption.ignoreHiddenNodes.rawValue : false]
        
        let hitTestLeftEye = virtualPhoneNode.hitTestWithSegment(
            from: virtualPhoneNode.convertPosition(self.vectorOfEye!.leftEye.worldPosition, from:nil),
            to:  virtualPhoneNode.convertPosition(self.vectorOfEye!.leftEyeEnd.worldPosition, from:nil),
            //from: self.vectorOfEye!.leftEye.worldPosition,
            //to:  self.vectorOfEye!.leftEyeEnd.worldPosition,
            options: options)
        
        let hitTestRightEye = virtualPhoneNode.hitTestWithSegment(
            from: virtualPhoneNode.convertPosition(self.vectorOfEye!.rightEye.worldPosition, from:nil),
            to:  virtualPhoneNode.convertPosition(self.vectorOfEye!.rightEyeEnd.worldPosition, from:nil),
            //from: self.vectorOfEye!.rightEye.worldPosition,
            //to:  self.vectorOfEye!.rightEyeEnd.worldPosition,
            options: options)
        
    //MARK: - 生成lookAtPoint
        if (hitTestLeftEye.count > 0 && hitTestRightEye.count > 0) {
            let coords = lookAtPointFromHittest(hitTestLeftEye[0], secondResult:hitTestRightEye[0])
            
            DispatchQueue.global().async {
                //将point位置传给代理
                let lookAtPoint = CGPoint.init(x: CGFloat(coords.x), y:CGFloat(coords.y))
                self.delegate?.traceLookAtPoint(point: lookAtPoint)
                
            }
        }
    }
    
    
    
}



