//
//  TransactionsSummaryView.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import SwiftUI


struct TransactionsSummaryView: View {
    
    @StateObject private var vm = TransactionSummaryViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.ignoresSafeArea()

            Image("footer")
            .resizable()
            .ignoresSafeArea(edges: .bottom)
            .frame(height: 102.scaledHeight())
            .opacity(0.4)
            .blur(radius: 28)
            
         
                VStack(spacing: 0){
                    SCPortfolioCard(
                        currency: FiatCurrency.inr,
                        portfolioValue: 157342.05,
                        deltaAmount: 1342,
                        deltaPercent: 4.6
                    )
                    
                    HStack(spacing: 20.scaledUniform()){
                        
                        SCActionButton(
                            icon: "arrow.up",
                            height: 52.scaledUniform(),
                            width: 52.scaledUniform(),
                            onTap: {}
                        )
                        
                        SCActionButton(
                            icon: "plus",
                            height: 52.scaledUniform(),
                            width: 52.scaledUniform(),
                            onTap: {}
                        )
                        
                        SCActionButton(
                            icon: "arrow.down",
                            height: 52.scaledUniform(),
                            width: 52.scaledUniform(),
                            onTap: {}
                        )
                        
                    }
                    .padding(.top,50.scaledUniform())
                    
                    HStack{
                        
                        Text("Transactions")
                            .font(SCFont.geistMono(14, .regular).font)
                            .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.64))
                        
                        Spacer()
                        
                        Text("Last 4 days")
                            .font(SCFont.interDisplay(14, .regular).font)
                            .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))
                    }
                    .padding(20.scaledUniform())
                    
                    ScrollView {
                        VStack(spacing: 10.scaledUniform()){
                            ForEach(vm.transactions, id: \.id) { transaction in
                                SCTransactionCard(
                                    image: nil,
                                    type: transaction.type,
                                    date: transaction.date,
                                    currencyCode: transaction.currency.code,
                                    amount: transaction.amount
                                )
                                .task {
                                    guard !vm.isFetching else { return }
                                    
                                    guard let lastItem = vm.transactions.last else { return }
                                    
                                    if lastItem.id == transaction.id {
                                        await vm.onFetchMore()
                                    }
                                }
                            }
                            
                            if vm.isFetching {
                                ProgressView()
                            }
                            
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    
                }
            
        }
    }
}

#Preview {
    TransactionsSummaryView()
}
