//
//  CGFloat+extension.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 26/01/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

extension CGFloat{
    var dp: CGFloat{
        return (self / 320) * UIScreen.main.bounds.width
    }
}
