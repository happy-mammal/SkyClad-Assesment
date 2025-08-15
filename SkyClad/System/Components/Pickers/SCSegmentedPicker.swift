//
//  SCSegmentedPicker.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import SwiftUI

struct SCSegmentedPicker<Data: RandomAccessCollection, Selection: Hashable>: View where Data.Element == Selection {
    
    @Binding var selection: Selection
    let data: Data
    let labelProvider: (Selection) -> LabelType
    
    enum LabelType {
        case text(String, Font)
        case image(Image, CGSize)
    }
    
    // Colors
    let activeTextColor: Color
    let inactiveTextColor: Color
    let activeBackgroundColor: Color
    let inactiveBackgroundColor: Color
    
    let capsulePadding: CGFloat = 5
    
    init(
        data: Data,
        selection: Binding<Selection>,
        activeTextColor: Color = .white,
        inactiveTextColor: Color = .gray,
        activeBackgroundColor: Color = Color(hex: "#100E11"),
        inactiveBackgroundColor: Color = Color(hex: "#212121").opacity(0.20),
        label: @escaping (Selection) -> LabelType
    ) {
        self.data = data
        self._selection = selection
        self.labelProvider = label
        self.activeTextColor = activeTextColor
        self.inactiveTextColor = inactiveTextColor
        self.activeBackgroundColor = activeBackgroundColor
        self.inactiveBackgroundColor = inactiveBackgroundColor
    }
    
    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let totalHeight = geo.size.height
            let availableWidth = totalWidth - capsulePadding * 2
            let availableHeight = totalHeight - capsulePadding * 2
            let segmentWidth = availableWidth / CGFloat(data.count)
            
            ZStack(alignment: .leading) {
                
                // Background capsule
                Capsule()
                    .fill(inactiveBackgroundColor)
                
                // Selected segment capsule
                Capsule()
                    .fill(activeBackgroundColor)
                    .frame(width: segmentWidth, height: availableHeight)
                    .offset(x: capsulePadding + offsetX(for: selection, segmentWidth: segmentWidth))
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: selection)
                    .allowsHitTesting(false)
                
                // Items
                HStack(spacing: 0) {
                    ForEach(Array(data), id: \.self) { option in
                        content(for: option)
                            .frame(width: segmentWidth, height: availableHeight)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                    selection = option
                                }
                            }
                    }
                }
                .padding(capsulePadding)
            }
        }
    }
    
    private func offsetX(for option: Selection, segmentWidth: CGFloat) -> CGFloat {
        guard let index = Array(data).firstIndex(of: option) else { return 0 }
        return CGFloat(index) * segmentWidth
    }
    
    @ViewBuilder
    private func content(for option: Selection) -> some View {
        let isSelected = option == selection
        
        switch labelProvider(option) {
        case .text(let str, let font):
            Text(str)
                .foregroundColor(isSelected ? activeTextColor : inactiveTextColor)
                .font(font)
        case .image(let img, let size):
                img
                .resizable()
                .scaledToFit()
                .foregroundColor(isSelected ? activeTextColor : inactiveTextColor)
                .padding(8)
                .frame(width: size.width, height: size.height)
        }
    }
}


#Preview {
    @Previewable @State var selected: String = "1h"
    
    let data = ["1h","8h","1d","1w","1m","6m", "1y"]
    ZStack(alignment: .center){
        Color.green.ignoresSafeArea()
        
        SCSegmentedPicker(
                    data: data,
                    selection: $selected,
                    activeTextColor: .white,
                    inactiveTextColor: .gray,
                    activeBackgroundColor: Color(hex: "#1A191B"),
                    inactiveBackgroundColor: .red
                ) { option in
                        .text(option, SCFont.interDisplay(14, .medium).font)
                }
                .frame(
                    width: 361.scaledUniform(),
                    height: 38.scaledUniform()
                )
    }
}
