//
//  SCActionButton.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import SwiftUI

struct SCActionButton: View {
    let icon: String
    let height: CGFloat?
    let width: CGFloat?
    let onTap: (()->Void)?
    
    init(icon: String,height: CGFloat? = nil, width: CGFloat? = nil, onTap: (() -> Void)?) {
        self.icon = icon
        self.height = height
        self.width = width
        self.onTap = onTap
    }
    
    private var getIconSize: CGSize {
        guard let baseWidth = width, let baseHeight = height else {
            return CGSize(width: 20.scaledUniform(), height: 20.scaledUniform())
        }
        
        let iconWidth: CGFloat = baseWidth - 32.scaledUniform()
        let iconHeight: CGFloat = baseHeight - 32.scaledUniform()
        
        return CGSize(width: iconWidth, height: iconHeight)
    }
    
    private var hasIconPadding: Bool {
        return width == nil || height == nil
    }
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            ZStack {
                
                LinearGradient(
                    colors: [
                        Color(hex: "#1A191B"),
                        Color(hex: "#0E0E10")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(Circle())
                
                
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(hex: "#FFFFFF").opacity(0.3),
                                Color(hex: "#999999").opacity(0)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                
                Circle()
                    .stroke(
                        Color(hex: "#3C3C3C"),
                        lineWidth: 1
                    )
                    .blur(radius: 4)
                    .offset(x: 1, y: 4)
                    .mask(Circle())
                

                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(hex: "#FFFFFF"))
                    .frame(
                        width: getIconSize.width,
                        height: getIconSize.height
                    )
                    .padding(hasIconPadding ? 10.scaledUniform() : 0)
                   
            }
            .frame(
                maxWidth: width ?? .infinity,
                maxHeight: height ?? .infinity
            )
            .fixedSize(
                horizontal: width == nil,
                vertical: width == nil
            )
        }


    }
}

#Preview {
    ZStack(alignment: .center){
        Color(hex: "#08080A").ignoresSafeArea()
        
        SCActionButton(
            icon: "arrow.up",
            height: 52.scaledUniform(),
            width: 52.scaledUniform(),
            onTap: {},
           
        )
        
    }
}
