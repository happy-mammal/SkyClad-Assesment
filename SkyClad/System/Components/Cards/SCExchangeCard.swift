//
//  ExchangeCardView.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI

struct SCExchangeCard: View {
    let currencies: [Currency]
    let transactionType: TransactionType
    @Binding var currency: Currency
    let balance: Double
    @Binding var amount: String
    let onChange: ()-> Void
    let isActive: Bool
    let onActiveStatus: ()-> Void
    private var getClipCorners: UIRectCorner {
        switch transactionType {
        case .send:
            return [.topLeft,.topRight]
        case .recieve:
            return [.bottomLeft, .bottomRight]
        case .exchange:
            return [.allCorners]
        }
    }
    
    private var numberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 7
        return f
    }
     
    var body: some View {
        ZStack{
            Color(hex: "#151517")
            
            VStack(alignment: .leading, spacing: 0){
            
                HStack(spacing: 0){
                    
                    if let image = currency.image {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 44.scaledWidth(),
                                height: 44.scaledWidth()
                            )
                    } else {
                        Circle()
                            .fill(Color(hex: "#FFFFFF").opacity(0.24))
                            .frame(
                                width: 44.scaledWidth(),
                                height: 44.scaledWidth()
                            )
                            .overlay {
                                Text(currency.symbol!)
                                    .foregroundStyle(Color(hex: "#FFFFFF"))
                                    .font(SCFont.interDisplay(20, .regular).font)
                            }
                    }
                    
                    
                    Text(currency.code)
                        .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))
                        .font(SCFont.geistMono(20, .regular).font)
                        .padding(.leading,20.scaledUniform())
                    
                    Menu {
                        ForEach(currencies, id: \.code) { c in
                            Button(c.code, action: {
                                currency = c
                            })
                        }
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(hex: "#CECECD").opacity(0.4))
                            .frame(
                                width: 16.scaledWidth(),
                                height: 16.scaledHeight()
                            )
                            .padding(.leading,8.scaledUniform())
                    }

                    
                    Spacer()
                    
                    Text(transactionType.text)
                        .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))
                        .font(SCFont.geistMono(14, .regular).font)
                    
                    
                }
               
                
                    HStack{
                        if let symbol = currency.symbol {
                            Text(symbol)
                                .foregroundStyle(Color(hex: "#FCFCFA"))
                                .font(SCFont.interDisplay(32, .medium).font)
                        }
                        if isActive {
                            TextField("Some TF", text: $amount)
                                .foregroundStyle(Color(hex: "#FCFCFA"))
                                .font(SCFont.interDisplay(32, .medium).font)
                                .keyboardType(.decimalPad)
                                .onChange(of: amount) { _, _ in
                                    onChange()
                                }
                        }else {
                            Text(amount)
                                .foregroundStyle(Color(hex: "#FCFCFA"))
                                .font(SCFont.interDisplay(32, .medium).font)
                                .keyboardType(.decimalPad)
                                .onTapGesture {
                                    onActiveStatus()
                                }
                        }
                    }
                    .padding(.top, 20.scaledUniform())
                   
                
                    
                
                HStack(spacing: 0){
                    
                    Text("Balance")
                        .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.4))
                        .font(SCFont.geistMono(14, .medium).font)
                
                    
                    Spacer()
                    
                    Text(numberFormatter.string(from: balance as NSNumber)!)
                        .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.4))
                        .font(SCFont.geistMono(14, .medium).font)
                    
                    
                }
                .padding(.top,30.scaledUniform())
                
                
                
            }
            .padding(.horizontal, 20.scaledUniform())
            
        }
        .frame(
            width: 361.scaledUniform(),
            height: 195.scaledUniform()
        )
        .clipShape(
            RoundedCorners(
                radius: 24.scaledWidth(),
                corners:  getClipCorners
            )
        )
    }
}

#Preview {
//    ExchangeCardView(
//        transactionType: .send,
//        currencyKind: .money("Indian Rupees", "INR", "₹"),
//        balance: 10.254,
//        amount: 2.640
//    )
    
//    SCExchangeCard(
//        transactionType: .send,
//        currency: CryptoCurrency.btc,
//        balance: 10.254,
//        amount: 2.640
//    )
}
