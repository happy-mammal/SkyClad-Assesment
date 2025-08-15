//
//  UIAPIs.swift
//  SkyClad
//
//  Created by Yash Lalit on 14/08/25.
//

import Foundation
import SwiftUICore

enum LabelType {
    case text(String, Font)
    case image(String, CGSize)
}

enum SCPillButtonScheme {
    case classic
    
    var foregroundColor: Color {
        switch self {
        case .classic:
            return Color(hex: "#FBFBFB")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .classic:
            return Color(hex: "#1E4DDB")
        }
    }
}
