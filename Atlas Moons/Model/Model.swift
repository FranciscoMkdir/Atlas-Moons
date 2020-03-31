//
//  Model.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 10/24/19.
//  Copyright © 2019 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

struct Planet {
    let type: TypePlanet
    
    var color: UIColor{
        switch type {
        case .earth: return UIColor(hexString: "#4F86E8")
        case .mars: return UIColor(hexString: "#B93F2A")
        case .jupiter: return UIColor(hexString: "#B96E35")
        case .saturn: return UIColor(hexString: "#A1937B")
        case .uranus: return UIColor(hexString: "#4C90A1")
        case .neptune: return UIColor(hexString: "#203796")
        case .pluto: return UIColor(hexString: "#ACA19B")
        }
    }
    
    var moons: Int{
        switch type {
        case .earth: return 1
        case .mars: return 2
        case .jupiter: return 4
        case .saturn: return 7
        case .uranus: return 5
        case .neptune: return 1
        case .pluto: return 1
        }
    }
    
    var sizeMoons: SizeMoon{
        switch type{
        case .earth: return .large
        case .mars: return .middle
        case .saturn: return .smaller
        case .jupiter: return .smaller
        case .uranus: return .smaller
        case .neptune: return .small
        case .pluto: return .small
        }
    }
    
    var distanceMoons: CGFloat{
        switch type{
        case .earth: return 3.0
        case .mars: return Bool.random() ? 3.0 : 3.6
        case .saturn: return Bool.random() ? 3.2 : 2.5
        case .jupiter: return  Bool.random() ? 3.0 : 2.5
        case .uranus: return Bool.random() ? 3.5 : 2.5
        case .neptune: return 3.5
        case .pluto: return 3.5
        }
    }
    
    var sizePlanet: CGFloat{
        switch type {
        case .earth: return CGFloat(18).dp
        case .mars: return CGFloat(15).dp
        case .jupiter: return CGFloat(26).dp
        case .saturn: return CGFloat(23).dp
        case .uranus: return CGFloat(22).dp
        case .neptune: return CGFloat(20).dp
        case .pluto: return CGFloat(10).dp
        }
    }
}

enum TypePlanet {
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
}



enum SizeMoon: CGFloat {
    case smaller = 0.1
    case small = 0.12
    case middle = 0.15
    case large = 0.18
}

