//
//  BottomNavBar.swift
//  SkyClad
//
//  Created by Yash Lalit on 14/08/25.
//

import SwiftUI

struct SCBottomNavBar<T: TabBarItem>:View{
    
    @Binding var selection: T
    
    let data: [T]
    
    let activeItemColor: Color
    let inActiveItemColor: Color
    
    let activeItemBackgroundColor: any ShapeStyle
    let inActiveItemBackgroundColor: any ShapeStyle
    
    let capsulePadding: CGFloat = 5
    
    init(
        data: [T],
        selection: Binding<T>,
        activeItemColor: Color  = Color.white,
        inActiveItemColor: Color = Color.gray,
        activeItemBackgroundColor: any ShapeStyle = Color.blue,
        inActiveItemBackgroundColor: any ShapeStyle = Color.clear
    ) {
        self.data = data
        self._selection = selection
        self.activeItemColor = activeItemColor
        self.inActiveItemColor = inActiveItemColor
        self.activeItemBackgroundColor = activeItemBackgroundColor
        self.inActiveItemBackgroundColor = inActiveItemBackgroundColor
    }
    
    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let totalHeight = geo.size.height
            let availableWidth = totalWidth - capsulePadding * 2
            let availableHeight = totalHeight - capsulePadding * 2
            let segmentWidth = availableWidth / CGFloat(data.count)
            
            ZStack(alignment: .leading) {
                
                background
                
                Capsule()
                    .fill(AnyShapeStyle(activeItemBackgroundColor))
                    .frame(width: segmentWidth, height: availableHeight)
                    .offset(x: capsulePadding + offsetX(for: selection, segmentWidth: segmentWidth))
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: selection)
                    .allowsHitTesting(false)
                
                // Items
                HStack(spacing: 0) {
                    ForEach(data, id: \.id) { option in
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
    
    private func offsetX(for option: T, segmentWidth: CGFloat) -> CGFloat {
        guard let index = Array(data).firstIndex(of: option) else { return 0 }
        return CGFloat(index) * segmentWidth
    }
    
    @ViewBuilder
    private func content(for option: T) -> some View {
        let isSelected = option == selection
        
        VStack {
            Image(systemName: option.icon)
            .resizable()
            .scaledToFit()
            .foregroundColor(isSelected ? activeItemColor : inActiveItemColor)
            .frame(
                width: 24.scaledUniform(),
                height: 24.scaledUniform()
            )
            
            Text(option.title)
                .font(SCFont.interDisplay(10, .medium).font)
                .foregroundColor(isSelected ? activeItemColor : inActiveItemColor)
        }
    }
}

extension SCBottomNavBar {
    
    var background: some View {
        ZStack {
            // Frosty blurred background
            VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#414247").opacity(0.24),
                            Color(hex: "#0B0B0B").opacity(0.64),
                            Color(hex: "#E1E1E1").opacity(0.24)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.8) // stronger frost tint
                )

            // Inner highlight for bevel
            RoundedRectangle(
                cornerRadius: 52.scaledUniform(), style: .continuous)
                .stroke(Color.white.opacity(0.6), lineWidth: 1)
                .blendMode(.screen)
                .offset(y: 0.5)

            // Inner shadow for depth
            RoundedRectangle(
                cornerRadius: 52.scaledUniform(), style: .continuous)
                .stroke(Color.black.opacity(0.25), lineWidth: 1)
                .blur(radius: 1)
                .offset(y: -0.5)
        }
        .clipShape(RoundedRectangle(
            cornerRadius: 52.scaledUniform(), style: .continuous))
        // Outer shadow to lift glass
        .shadow(color: Color.black.opacity(0.3), radius: 8.scaledUniform(), x: 0, y: 4)
        .shadow(color: Color.white.opacity(0.08), radius: 1.scaledUniform(), x: 0, y: -1)
    }
}
#Preview {
    
    @Previewable @State var selected: HomePageTabBarItem = .analytics
    
    SCBottomNavBar(
        data: HomePageTabBarItem.allCases,
        selection: $selected,
        activeItemColor: Color(hex: "#E1E1E1"),
        inActiveItemColor: Color(hex: "#CDCDCD"),
        activeItemBackgroundColor: LinearGradient(
            colors: [
                Color(hex: "#6F88FA").opacity(0.32),
                Color(hex: "#222DEC")
            ],
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        ),
        inActiveItemBackgroundColor: Color.clear,
        
    )
    .frame(
        width: 283.scaledUniform(),
        height: 63.scaledUniform()
    )
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
