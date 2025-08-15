//
//  SCFont.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import Foundation
import SwiftUICore

enum SCFont {
    case geistMono(CGFloat,Font.Weight)
    case interDisplay(CGFloat, Font.Weight)
    
    var font : Font {
        switch self {
        case .geistMono(let size, let weight):
            return .variableFont(name: "Geist Mono", size: size.scaledWidth(), weight: weight.numericValue)
        case .interDisplay(let size, let weight):
            return .variableFont(name: "Inter", size: size.scaledWidth(), weight: weight.numericValue)
        }
    }
}
