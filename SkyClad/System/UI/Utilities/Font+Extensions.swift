//
//  Font+Extensions.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI
import CoreText

extension Font {
    
    static func variableFont(name: String, size: CGFloat, weight: CGFloat) -> Font {
        
        guard let uiFont = UIFont(name: name, size: size) else {
            return .system(size: size)
        }
        

        let wghtTag = CTFontManagerConvertFourCharCode("wght")
        
        let variation: [NSNumber: CGFloat] = [
            NSNumber(value: wghtTag): weight
        ]
        
        let descriptor = uiFont.fontDescriptor.addingAttributes([
            kCTFontVariationAttribute as UIFontDescriptor.AttributeName: variation
        ])
        
        let newUIFont = UIFont(descriptor: descriptor, size: size)
        
        return Font(newUIFont)
    }

    // Helper to convert "wght" to OSType
    private static func CTFontManagerConvertFourCharCode(_ string: String) -> Int {
        var result: Int = 0
        for scalar in string.unicodeScalars {
            result = (result << 8) + Int(scalar.value)
        }
        return result
    }
}

