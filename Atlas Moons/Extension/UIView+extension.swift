//
//  UIView+extension.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 30/04/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

extension UIView{
    func prepareForAnimation(position: PositonAnimation){
        alpha = 0.0
        switch position {
        case .bottom: transform = CGAffineTransform(translationX: 0, y: -10)
        case .left: transform = CGAffineTransform(translationX: -10, y: 0)
        case .right: transform = CGAffineTransform(translationX: 10, y: 0)
        case .top: transform = CGAffineTransform(translationX: 0, y: 10)
        }
    }
    
    func animateShow(delay: TimeInterval = 0.0){
        animate(inParallel: [.fadeIn(delay: delay), .applyTransform(.identity, delay: delay)])
    }
    
    func animate(show: Bool, withDimissTransform transform: CGAffineTransform? = nil){
        if show{
            animate(inParallel: [ .fadeIn(), .applyTransform(.identity)])
        }else{
            guard let transform = transform else {
                animate(inParallel: [ .fadeOut()])
                return
            }
            animate(inParallel: [ .fadeOut(), .applyTransform(transform)])
        }
    }
    
    @discardableResult
    func add<T: UIView>(_ subview: T, then closure: (T) -> Void) -> T {
        addSubview(subview)
        closure(subview)
        return subview
    }
}
