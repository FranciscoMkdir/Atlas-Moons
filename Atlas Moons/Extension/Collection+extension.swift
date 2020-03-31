//
//  Collection+extension.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 30/03/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
