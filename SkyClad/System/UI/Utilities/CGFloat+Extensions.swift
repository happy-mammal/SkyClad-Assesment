//
//  CGFloat+Extensions.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import Foundation

import SwiftUI

extension BinaryInteger {
    func scaledWidth(baseWidth: CGFloat = 375) -> CGFloat {
        CGFloat(self) * UIScreen.main.bounds.width / baseWidth
    }
    func scaledHeight(baseHeight: CGFloat = 812) -> CGFloat {
        CGFloat(self) * UIScreen.main.bounds.height / baseHeight
    }
    
    func scaledUniform(baseWidth: CGFloat = 375, baseHeight: CGFloat = 812) -> CGFloat {
            let minDimension = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            let baseMinDimension = min(baseWidth, baseHeight)
            return CGFloat(self) * minDimension / baseMinDimension
    }
}

extension BinaryFloatingPoint {
    func scaledWidth(baseWidth: CGFloat = 375) -> CGFloat {
        CGFloat(self) * UIScreen.main.bounds.width / baseWidth
    }
    func scaledHeight(baseHeight: CGFloat = 812) -> CGFloat {
        CGFloat(self) * UIScreen.main.bounds.height / baseHeight
    }
    
    func scaledUniform(baseWidth: CGFloat = 375, baseHeight: CGFloat = 812) -> CGFloat {
            let minDimension = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            let baseMinDimension = min(baseWidth, baseHeight)
            return CGFloat(self) * minDimension / baseMinDimension
    }
}
