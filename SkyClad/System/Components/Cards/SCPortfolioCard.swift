//
//  CardStackView.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import SwiftUI


struct SCPortfolioCard: View {
    
    private func isTopCard(_ index: Int) -> Bool {
        index == 0
    }
    
    let currency: Currency
    
    let portfolioValue: Double
    
    let deltaAmount: Double
    
    let deltaPercent: Float
    
    
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
    
    private var numberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 2
        return f
    }

    private var getFormattedDeltaAmount: String {
        guard let symbol = currency.symbol else {
            return numberFormatter.string(from: deltaAmount as NSNumber)!
        }
        
        return symbol + " " + numberFormatter.string(from: deltaAmount as NSNumber)!
    }
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 24.scaledUniform())
            .fill(Color(hex: "#111768"))
            .frame(
                width: 325.scaledUniform(),
                height: 159.scaledUniform()
            )
            .offset(y:36.scaledUniform())
            
            RoundedRectangle(cornerRadius: 24.scaledUniform())
                .fill(Color(hex: "#2A1F7F"))
                .frame(
                    width: 345.scaledUniform(),
                    height: 169.scaledUniform()
                )
            .offset(y:18.scaledUniform())
            
            ZStack{
                Image("footer")
                .resizable()
                .scaledToFill()
                .rotationEffect(.degrees(90))
                
                VStack(spacing: 0){
                    Text(currency.code)
                        .font(SCFont.geistMono(14, .medium).font)
                        .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))
                        .padding(10.scaledUniform())
                        .background(
                            RoundedRectangle(cornerRadius: 12.scaledUniform())
                                .fill(Color(hex: "#000000").opacity(0.3))
                        )
                    
                    Text(numberFormatter.string(from: portfolioValue as NSNumber)!)
                        .font(SCFont.interDisplay(40, .medium).font)
                        .foregroundStyle(Color(hex: "#FCFCFA"))
                        .padding(.top, 10.scaledUniform())
                    
                    HStack{
                        Text(getFormattedDeltaAmount)
                            .font(SCFont.interDisplay(14, .medium).font)
                            .foregroundStyle(Color(hex: "#FAFADE").opacity(0.64))
                        
                        Text(deltaFormatter.string(from: deltaPercent as NSNumber)!)
                            .font(SCFont.geistMono(14, .medium).font)
                            .foregroundStyle(Color(hex: "#11C17B"))
                            .padding(.leading, 10.scaledUniform())
                    }
                    .padding(.top, 5.scaledUniform())
                    
                   Spacer()
                }
                .padding(20.scaledUniform())
                .frame(
                    width: 361.scaledUniform(),
                    height: 177.scaledUniform()
                )
                
            }
            .frame(
                width: 361.scaledUniform(),
                height: 177.scaledUniform()
            )
            .clipShape(RoundedRectangle(cornerRadius: 24.scaledUniform()))
            
            
            
        }
    }
    


}


#Preview {
    SCPortfolioCard(
        currency: FiatCurrency.inr,
        portfolioValue: 157342.05,
        deltaAmount: 1342,
        deltaPercent: 4.6
    )
}
