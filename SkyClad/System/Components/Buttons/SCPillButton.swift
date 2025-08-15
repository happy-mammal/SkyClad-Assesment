//
//  SCPillButton.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI

struct SCPillButton: View {
    let title: String
    let font: SCFont
    let scheme: SCPillButtonScheme
    let width: CGFloat?
    let height: CGFloat?
    let onTap: (()->Void)?
    
    init(title: String, font: SCFont,scheme: SCPillButtonScheme, width: CGFloat? = nil, height: CGFloat? = nil, onTap: (() -> Void)? = nil) {
        self.title = title
        self.font = font
        self.scheme = scheme
        self.width = width
        self.height = height
        self.onTap = onTap
    }
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            ZStack {
                Capsule().fill(scheme.backgroundColor)
                
                Text(title)
                    .font(font.font)
                    .foregroundStyle(scheme.foregroundColor)
                    .padding(.horizontal)
                    .padding(.vertical,10)
                
                
            }
            .frame(
                maxWidth: width ?? .infinity,
                minHeight: height ?? 0,
                maxHeight: height ?? .infinity
               
            )
            .fixedSize(
                horizontal: width == nil,
                vertical: height == nil
            )
        }

    }
}

#Preview {
    SCPillButton(
        title: "Exchange",
        font: .geistMono(26, .bold),
        scheme: .classic,
        width: nil,
        height: nil
    )
}
