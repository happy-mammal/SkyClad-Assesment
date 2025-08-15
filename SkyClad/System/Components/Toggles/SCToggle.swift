//
//  SCToggle.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import SwiftUI

struct SCToggle: View {
    
    @Binding var isOn: Bool
    
    let activeBackgroundColor: Color
    let inactiveBackgroundColor: Color
    let activeContentColor: Color
    let inactiveContentColor: Color
    
    let primaryLabel: LabelType
    let secondaryLabel: LabelType
    
    // unified internal padding used for BOTH highlight and labels
    private let internalPadding: CGFloat = 6
    
    var body: some View {
        GeometryReader { geo in
            let totalWidth  = geo.size.width
            let totalHeight = geo.size.height
            
            // inner area (the background capsule’s “content” bounds)
            let availableWidth  = max(0, totalWidth  - internalPadding * 2)
            let availableHeight = max(0, totalHeight - internalPadding * 2)
            let segmentWidth    = availableWidth / 2
            
            ZStack(alignment: .leading) {
                // background
                Capsule()
                    .fill(inactiveBackgroundColor)
                    .overlay(Capsule().fill(inactiveBackgroundColor.opacity(0.14)))
                
                // moving highlight (exactly one inner segment wide)
                Capsule()
                    .fill(activeBackgroundColor)
                    .frame(width: segmentWidth, height: availableHeight)
                    .offset(x: internalPadding + (isOn ? segmentWidth : 0))
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isOn)
                    .allowsHitTesting(false) // let taps go through
                
                // labels (centered in each half, inside the same inner padded area)
                HStack(spacing: 0) {
                    ZStack {
                        labelView(for: primaryLabel, active: !isOn)
                    }
                    .frame(width: segmentWidth, height: availableHeight)
                    
                    ZStack {
                        labelView(for: secondaryLabel, active: isOn)
                    }
                    .frame(width: segmentWidth, height: availableHeight)
                }
                .padding(internalPadding) // matches highlight math
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                isOn.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func labelView(for label: LabelType, active: Bool) -> some View {
        switch label {
        case .text(let str, let font):
            Text(str)
                .font(font)
                .foregroundColor(active ? activeContentColor : inactiveContentColor)
        case .image(let systemName, let size):
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
                .foregroundColor(active ? activeContentColor : inactiveContentColor)
        }
    }
}




#Preview {
    @Previewable @State var isBitcoin = false

    ZStack(alignment: .center){
        Color(hex: "#08080A").ignoresSafeArea()
        
        SCToggle(
            isOn: $isBitcoin,
            activeBackgroundColor: .blue,
            inactiveBackgroundColor: .gray.opacity(0.3),
            activeContentColor: .white,
            inactiveContentColor: .black,
            primaryLabel: .image(
                "sun.max.fill",
                CGSize(width: 18.scaledUniform(), height: 18.scaledUniform())
            ),
            secondaryLabel: .image(
                "moon.fill",
                CGSize(width: 18.scaledUniform(), height: 18.scaledUniform())
            )
        )
        .frame(
            width: 100.scaledUniform(),
            height: 40.scaledUniform()
        )
    }
}
