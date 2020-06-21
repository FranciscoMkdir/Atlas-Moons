//
//  SCNNode+extension.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 08/05/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit
import SceneKit


extension SCNNode{
    func addSpin(duration: CFTimeInterval = 60){
        let spin = CABasicAnimation(keyPath: "rotation")
        spin.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: 0))
        spin.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(CGFloat(2 * Double.pi))))
        spin.duration = duration
        spin.repeatCount = .infinity
        self.addAnimation(spin, forKey: "rotation")
    }
}
