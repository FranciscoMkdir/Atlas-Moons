//
//  String+extension.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 25/04/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

extension UILabel {
    func setAttributes(text: String, font: UIFont, textSpacing: CGFloat, color: UIColor){
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern,
                                      value: textSpacing,
                                      range: NSRange(location: 0, length: attributedString.length - 1))
        attributedString.addAttribute(.foregroundColor,
                                      value: color,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.font,
                                      value: font,
                                      range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    func lblShadow(color: UIColor , radius: CGFloat, opacity: Float){
        self.textColor = color
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
