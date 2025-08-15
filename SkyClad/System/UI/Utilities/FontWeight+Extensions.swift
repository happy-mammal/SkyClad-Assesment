//
//  FontWeight+Extensions.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import Foundation
import SwiftUICore

extension Font.Weight {

    var numericValue: CGFloat {
        switch self {
        case .ultraLight: return 100
        case .thin:       return 200
        case .light:      return 300
        case .regular:    return 400
        case .medium:     return 500
        case .semibold:   return 600
        case .bold:       return 700
        case .heavy:      return 800
        case .black:      return 900
        default:          return 400
        }
    }
}
