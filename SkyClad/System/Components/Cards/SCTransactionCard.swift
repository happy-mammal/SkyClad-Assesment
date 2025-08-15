//
//  TransactionCardView.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI

struct SCTransactionCard: View {
    
    let image: String?
    let type: TransactionType
    let date: Date
    let currencyCode: String
    let amount: Double
    
    
    private func formattedDate (_ value: Date) -> String {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let dateYear = calendar.component(.year, from: value)
                
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
                
        if currentYear == dateYear {
            dateFormatter.dateFormat = "d MMMM"
        } else {
            dateFormatter.dateFormat = "d MMMM yyyy"
        }
                
        return dateFormatter.string(from:  value)
    }
    
    private var amountFormatter: NumberFormatter {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            f.minimumFractionDigits = 1
            f.maximumFractionDigits = 7
            f.positivePrefix = "+"
            return f
    }

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24.scaledUniform())
                .fill(Color(hex: "#151515"))
            
            HStack(spacing: 0){
                
                if let image {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 46.scaledUniform(),
                            height: 46.scaledUniform()
                        )
                }else {
                    RoundedRectangle(cornerRadius: 12.scaledUniform())
                        .fill(Color(hex: "#484848"))
                        .frame(
                            width: 46.scaledUniform(),
                            height: 46.scaledUniform()
                        )
                        .overlay {
                            Image(systemName: type.icon)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))
                                .frame(
                                    width: 24.scaledUniform(),
                                    height: 24.scaledUniform(),
                                )
                            
                        }
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text(type.text)
                        .foregroundStyle(Color(hex: "#FFFFFF"))
                        .font(SCFont.interDisplay(14, .medium).font)
                    
                    Spacer()
                    
                    Text(formattedDate(date))
                        .foregroundStyle(Color(hex: "#6F6F6F"))
                        .font(SCFont.interDisplay(14, .medium).font)
                    
                }
                .frame( height: 24.scaledUniform())
                .padding(.horizontal, 20.scaledUniform())
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0){
                    Text(currencyCode)
                        .foregroundStyle(Color(hex: "#FFFFFF"))
                        .font(SCFont.interDisplay(14, .medium).font)
                    
                    Spacer()
                    
                    Text(amountFormatter.string(from: amount as NSNumber)!)
                        .foregroundStyle(Color(hex: "#FFFFFF"))
                        .font(SCFont.interDisplay(16, .medium).font)
                    
                }
                .frame( height: 24.scaledUniform())
                
                
            }
            .padding(20.scaledUniform())
        }
        .frame(
            width: 361.scaledUniform(),
            height: 86.scaledUniform()
        )
    }
}

#Preview {
    ZStack(alignment: .center){
        Color("BackgroundColor").ignoresSafeArea()
        SCTransactionCard(
            image: nil,
            type: .send,
            date: .now,
            currencyCode: "BTC",
            amount: 0.0002167
        )
    }
}
