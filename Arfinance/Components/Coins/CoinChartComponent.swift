//
//  CoinChartComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 24/10/22.
//

import SwiftUI

struct CoinChartComponent: View {
	
	let data : [Double]
	private let maxY : Double
	private let minY : Double
	private let lineColor : Color
	private let startDate : Date
	private let endDate : Date
	@State private var chartAnimationHandler : CGFloat = .zero
	
	public init (coin : Coin) {
		self.data = coin.sparklineIn7D?.price ?? [] ;
		self.maxY = self.data.max() ?? 0 ;
		self.minY = self.data.min() ?? 0 ;
		
		self.lineColor = (((self.data.last ?? 0) - (self.data.first ?? 0)) > 0) ? .theme.green : .theme.red;
		
		self.endDate = coin.lastUpdated != nil ? Date(coin.lastUpdated!) : Date();
		self.startDate = self.endDate.addingTimeInterval(-7 * 24 * 60 * 60)
		
	}
	
	var body: some View {
		GeometryReader { geo in
			Path { path in
				for index in self.data .indices{
					let xPos = (geo.size.width / CGFloat(self.data.count)) * CGFloat(index + 1)
					let yAxis = self.maxY - self.minY ;
					let yPos = (1 - CGFloat((self.data[index] - minY) / yAxis)) * geo.size.height ;
					
					if index == 0 {
						path.move(to: CGPoint(x: xPos, y: yPos))
					}
					
					path.addLine(to: CGPoint(x: xPos, y:  yPos))
				}
			}
			.trim(from: .zero , to: self.chartAnimationHandler)
			.stroke(self.lineColor, style: .init(lineWidth: 2,lineCap: .round ,  lineJoin: .round ))
			.shadow(color: self.lineColor, radius:10, x:0, y:10)
			.shadow(color: self.lineColor.opacity(0.5), radius:10, x:0, y:20)
			.shadow(color: self.lineColor.opacity(0.2), radius:10, x:0, y:30)
			.shadow(color: self.lineColor.opacity(0.1), radius:10, x:0, y:40)
			.background(
				VStack{
					Divider()
					Spacer()
					Divider()
					Spacer()
					Divider()
				}
			)
			.overlay(
				VStack(alignment: .leading, spacing : 4){
					VStack{
						Text("\(self.maxY.formattedWithAbbreviations())")
						Spacer()
						Text(((self.maxY + self.minY) / 2).formattedWithAbbreviations())
						Spacer()
						Text("\(self.minY.formattedWithAbbreviations())")
					}
					HStack{
						Text(self.startDate.asShortDateString())
						Spacer()
						Text(self.endDate.asShortDateString())
					}
				}
					.padding(.all ,4 )
				, alignment: .leading
			).onAppear {
				DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0, execute: {
					withAnimation( .linear(duration: 3.0) ) {
						self.chartAnimationHandler = 1.0
					}
				})
			}
		}
		.foregroundColor(.theme.secondaryText)
	}
}

struct CoinChartComponent_Previews: PreviewProvider {
	static var previews: some View {
		CoinChartComponent(coin: DummyData.coin)
	}
}
