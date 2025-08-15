//
//  DashboardView.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI

struct PortfolioDashboardView: View {
    let screen = UIScreen.main.bounds

    @StateObject private var vm = PortfolioDashboardViewModel()
    
    var body: some View {
        
        VStack{
            
            ZStack(alignment: .leading){
                Image("header")
                    .resizable()
                    .rotationEffect(.degrees(180))
                    .clipShape(RoundedRectangle(cornerRadius: 24.scaledUniform()))
                    .ignoresSafeArea()
                
                     VStack(alignment: .leading){

                        Spacer()

                        HStack{
                            HStack(alignment: .center,spacing: 0){
                                Text("Portfolio Value")
                                    .font(SCFont.geistMono(14, .regular).font)
                                    .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))

                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color(hex: "#D2D3E6"))
                                    .frame(
                                        width: 10.scaledUniform(),
                                        height: 10.scaledUniform()
                                    )
                                    .padding(.leading,8.scaledUniform())
                            }

                            Spacer()

                            SCToggle(
                                isOn: $vm.showPortfolioValueInCrypto,
                                activeBackgroundColor: Color(hex: "#100E11"),
                                inactiveBackgroundColor: Color(hex: "#FCFCFC").opacity(0.1),
                                activeContentColor: Color(hex: "#FBFBFB"),
                                inactiveContentColor: Color(hex: "#6F6F6F"),
                                primaryLabel: .image(
                                    "banknote",
                                    CGSize(width: 18.scaledUniform(), height: 18.scaledUniform())
                                ),
                                secondaryLabel: .image(
                                    "bitcoinsign",
                                    CGSize(width: 18.scaledUniform(), height: 18.scaledUniform())
                                )
                            )
                            .frame(
                                width: 100.scaledUniform(),
                                height: 40.scaledUniform()
                            )
                        }

                         Text(vm.portfolioValue)
                            .font(SCFont.interDisplay(36, .medium).font)
                            .foregroundStyle(Color(hex: "#FCFCFA"))
                            //.padding(.bottom,10.scaledUniform())

                    }
                    .padding(20.scaledUniform())

            }
            .frame(
                width: 375.scaledUniform(),
                height: 239.scaledUniform()
            )
            
            ScrollView {
                VStack(alignment: .center,spacing: 0){
                    SCSegmentedPicker(
                        data: vm.availableChartDurations,
                        selection: $vm.selectedPortfolioChartDuration,
                        activeTextColor: .white,
                        inactiveTextColor: .gray,
                        activeBackgroundColor: Color(hex: "#1A191B"),
                        inactiveBackgroundColor: .clear
                    ) { option in
                            .text(option, SCFont.interDisplay(14, .medium).font)
                    }
                    .frame(
                        width: 361.scaledUniform(),
                        height: 38.scaledUniform()
                    )
                    
                    
                    SCPortfolioTrendChart()
                        .padding(.top,5.scaledUniform())
                       
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            
                            ForEach(Array(vm.assets.enumerated()), id: \.element.id) { index, asset in
                                SCAssetCard(
                                    isSelected: index % 2 == 0,
                                    image: asset.currency.image!,
                                    name: "\(asset.currency.name) (\(asset.currency.code)",
                                    value: asset.value,
                                    delta: asset.delta
                                )
                            }
                            
                            
                           
                        }
                        .padding(.top,20.scaledUniform())
                        
                    }
                    
                    Text("Recent Transactions")
                        .font(SCFont.geistMono(14, .regular).font)
                        .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.64))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,20.scaledUniform())
                    
                    ForEach(vm.recentTransactions
                            , id: \.id) { transaction in
                        SCTransactionCard(
                            image: transaction.currency.image,
                            type: transaction.type,
                            date: transaction.date,
                            currencyCode: transaction.currency.code,
                            amount: transaction.amount
                        )
                        .padding(.top)
                        
                    }
                }
                .padding(.horizontal,20.scaledUniform())
            }
           
        }
        .background(Color(hex: "#08080A"))
 
       
    }
}

#Preview {
    ZStack(alignment: .top){
        Color.black.ignoresSafeArea()
        
        PortfolioDashboardView()
    }
}
