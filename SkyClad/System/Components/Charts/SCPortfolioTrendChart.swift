//
//  PortfolioTrendChart.swift
//  SkyClad
//
//  Created by Yash Lalit on 13/08/25.
//

import SwiftUI
import Charts

struct TimeFrameData: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

struct SCPortfolioTrendChart: View {
    @State private var selectedLabel: String? = "6m"
    
    let data: [TimeFrameData] = [
        .init(label: "1h", value: 95.3),
        .init(label: "8h", value: 162.57),
        .init(label: "1d", value: 120.93),
        .init(label: "1w", value: 156.16),
        .init(label: "1m", value: 148.95),
        .init(label: "6m", value: 181.79),
        .init(label: "1y", value: 193)
    ]
    
    var body: some View {
        Chart {
            // Bars
            ForEach(data) { item in
                BarMark(
                    x: .value("Timeframe", item.label),
                    y: .value("Value", item.value),
                    width: MarkDimension(floatLiteral: 42.scaledUniform()),
                    
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hex: "#151515"),
                            Color(hex: "#08080A"),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(8.scaledUniform())
            }
            
          
            ForEach(data) { item in
                LineMark(
                    x: .value("Timeframe", item.label),
                    y: .value("Curve", item.value - 95)
                )
                
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color(hex: "#11C17B"))
                .lineStyle(StrokeStyle(lineWidth: 1))
            }
            
            // Marker line
            if let selectedLabel, let selectedItem = data.first(where: { $0.label == selectedLabel }) {
                
                RectangleMark(
                    x: .value("Selected", selectedLabel),
                    yStart: .value("Bottom", 0),
                    yEnd: .value("Top", selectedItem.value),
                    width: 1,
                )
                .foregroundStyle(Color(hex: "#FCFCFA"))
                
                PointMark(
                    x: .value("Selected", selectedLabel),
                    y: .value("Curve", selectedItem.value)
                )
                .symbol {
                    Circle()
                        .stroke(Color(hex: "#FCFCFA"))
                        .frame(
                            width: 15.scaledUniform(),
                            height: 15.scaledUniform()
                        )
                        .overlay(content: {
                            Circle()
                                .fill(Color(hex: "#FCFCFA"))
                                .frame(
                                    width: 8.57.scaledUniform(),
                                    height: 8.57.scaledUniform()
                                )
                        })
                }
                .annotation(position: .leading) {
                    
                    VStack{
                        Text("24 March")
                            .font(SCFont.interDisplay(12, .medium).font)
                            .foregroundStyle(Color(hex: "#E1E1E1").opacity(0.4))
                        
                        Text("₹ 1,42,340")
                            .font(SCFont.interDisplay(16, .medium).font)
                            .foregroundStyle(Color(hex: "#E1E1E1").opacity(0.8))
                    }
                    .padding(.trailing)
                    
                   
                }

            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: 215.scaledUniform())
    }
}



#Preview {
    SCPortfolioTrendChart()
}
