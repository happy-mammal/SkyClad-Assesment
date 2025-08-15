//
//  AssetCardView.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI

struct SCAssetCard: View {
    let isSelected: Bool
    let image: String
    let name: String
    let value: Double
    let delta: Float
    
    private var deltaFormatter: NumberFormatter {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            f.minimumFractionDigits = 1
            f.maximumFractionDigits = 3
            f.positivePrefix = "+"
            f.positiveSuffix = "%"
            f.negativeSuffix = "%"
            return f
    }
    
    private var valueFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale.current
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 2
        if let symbol = f.currencySymbol {
               f.currencySymbol = symbol + " "
           }
        return f
    }

    var body: some View {
        
        ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "#0D0C0D"))
            }
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(hex: "#151517"),
                            Color(hex: "#2B2B2B"),
                            Color(hex: "#151517"),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
            
            VStack(spacing: 0){
                HStack {
                    Image(image)
                        .resizable()
                        .frame(
                            width: 42.scaledWidth(),
                            height: 42.scaledHeight()
                        )
                    
                    Spacer()
                    
                    Text(name)
                        .foregroundStyle(Color(hex: "#FCFCFACC").opacity(0.8))
                        .font(SCFont.geistMono(14, .regular).font)
                    
                }
                
                HStack {
                    Text(valueFormatter.string(from: value as NSNumber)!)
                        .foregroundStyle(Color(hex: "#CCCCCB"))
                        .font(SCFont.interDisplay(16, .regular).font)
                    
                    Spacer()
                    
                    Text(deltaFormatter.string(from: delta as NSNumber)!)
                        .foregroundStyle(Color(hex: "#11C17B"))
                        .font(SCFont.interDisplay(12, .medium).font)
                    
                    
                }
                .padding(.top,25.scaledHeight())
            }
            .padding()
            
            
        }
        .frame(
            width: 204.scaledWidth(),
            height: 118.scaledHeight()
        )
            
    }
}

#Preview {
    
    ZStack(alignment: .center){
        Color("BackgroundColor").ignoresSafeArea()
        ScrollView(.horizontal) {
            HStack{
                SCAssetCard(
                    isSelected: true,
                    image: "Bitcoin",
                    name: "Bitcoin (BTC)",
                    value: 7562502.14,
                    delta: 3.2
                )
                
                SCAssetCard(
                    isSelected: false,
                    image: "Etherium",
                    name: "Etherium (ETH)",
                    value: 5462502.14,
                    delta: 3.2
                )
            }
        }
            
    }
}
