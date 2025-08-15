//
//  HomeView.swift
//  SkyClad
//
//  Created by Yash Lalit on 14/08/25.
//

import SwiftUI


struct HomeView: View {
    
    private let screen = UIScreen.main.bounds
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack{
           
            content
            
        }
        .toolbar {
            leadingToolbarItems
            
            trailingToolbarItems
        }
        .safeAreaInset(edge: .bottom) {
            ZStack {
                
                blurFooter
               
                if vm.selectedTabItem.shouldShowTabBar{
                    bottomNavBar
                }
                
            }
            .animation(.bouncy, value: vm.selectedTabItem)
           
            

        }
        .frame(
            width: screen.width,
            height: screen.height
        )
    }
}

extension HomeView {
    
    var content: some View {
        TabView(selection: $vm.selectedTabItem){
            PortfolioDashboardView()
                .ignoresSafeArea()
                .tag(HomePageTabBarItem.analytics)
            
            ExchangeView()
                .tag(HomePageTabBarItem.exchange)
            
            TransactionsSummaryView()
                .tag(HomePageTabBarItem.record)
        }
    }
    
    var leadingToolbarItems: some ToolbarContent {
        
        ToolbarItem(placement: .topBarLeading) {
            
            HStack{
                
                Button {
                    vm.onLeadingIconPressed()
                } label: {
                    Image(systemName: vm.selectedTabItem.topBarLeadingIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(hex: "#E1E1E1").opacity(0.8))
                        .frame(
                            width: 24.scaledUniform(),
                            height: 24.scaledUniform()
                        )
                        .padding(.leading,10.scaledUniform())
                }
                
                if let title = vm.selectedTabItem.topBarTitle {
                    Text(title)
                        .font(SCFont.geistMono(16, .medium).font)
                        .foregroundStyle(Color(hex: "#FFFFFF"))
                        .padding(.leading,20.scaledUniform())
                }
            }
            
            
        }
        
    }
    
    var trailingToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if let icon  = vm.selectedTabItem.topBarTrailingIcon {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(hex: "#E1E1E1").opacity(0.8))
                    .frame(
                        width: 24.scaledUniform(),
                        height: 24.scaledUniform()
                    )
                    .padding(.trailing,10.scaledUniform())
            }
        }
    }
    
    var bottomNavBar: some View {
        HStack{
            SCBottomNavBar(
                data: HomePageTabBarItem.allCases,
                selection: $vm.selectedTabItem,
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
            
            Spacer()
            
            Circle().fill(.white)
                .frame(
                    width: 63.scaledUniform(),
                    height: 63.scaledUniform()
                )
                .overlay {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(hex: "#222DEC"))
                        .frame(
                            width: 24.scaledUniform(),
                            height: 24.scaledUniform()
                        )
                }
        }
        .safeAreaPadding(.horizontal, 20)
        .padding(.bottom,60)
        .transition(.move(edge: .bottom))
    }
    
    var blurFooter: some View {
        Image("footer")
        .resizable()
        .ignoresSafeArea(edges: .bottom)
        .frame(height: 102.scaledHeight())
        .opacity(0.4)
        .blur(radius: 28)
    }
}

#Preview {
    NavigationStack {
        HomeView()
         
    }
    
}
