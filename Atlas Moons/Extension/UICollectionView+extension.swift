//
//  UICollectionView+extension.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 30/03/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

extension UICollectionView {
    func scrollToNextItem(sizeCell: CGFloat) {
        let contentOffset = CGFloat(floor(self.contentOffset.x + sizeCell))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem(sizeCell: CGFloat) {
        let contentOffset = CGFloat(floor(self.contentOffset.x - sizeCell))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}
