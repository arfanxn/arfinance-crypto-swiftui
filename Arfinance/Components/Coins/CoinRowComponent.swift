//
//  CoinRowComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 18/10/22.
//

import SwiftUI

struct CoinRowComponent: View {
	
	let coin : Coin;
	var showHoldingsColumn : Bool = false;
	
	var coinInfo : some View {
		Group(content: {
			Text("\(self.coin.rank)")
				.font(.caption)
				.foregroundColor(.theme.secondaryText)
				.frame(minWidth: 20)
			CoinLogoComponent(coin: coin)
				.frame(width: 30 , height: 30)
			Text(self.coin.symbol.uppercased())
				.font(.headline)
				.padding(.leading , 6)
				.foregroundColor(.theme.accent)
		})
	}
	
	var coinPrice : some View {
		VStack{
			Text("\(self.coin.currentPrice.asCurrencyWith2Decimals())")
				.foregroundColor(.theme.accent)
			Text("\(self.coin.priceChange24H?.asPercentString() ?? "")")
				.foregroundColor((self.coin.priceChange24H ?? 0) >= 0 ? .theme.green : .theme.red)
		}
		.frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
	}
	
	var coinHoldingsInfo : some View {
		VStack(alignment: .trailing){
			Text(self.coin.currentHoldingsValue.asCurrencyWith2Decimals())
				.bold()
			Text((self.coin.currentHoldings ?? 0).asNumberString())
				.foregroundColor(.theme.accent)
		}
	}
	
	var body: some View { // start of body
		HStack(spacing: 0){
			self.coinInfo
			
			Spacer()
			
			if (self.showHoldingsColumn) {
				self.coinHoldingsInfo
			}
			
			self.coinPrice
			
		}
		.font(.subheadline)
		.background(Color.theme.background.opacity(0.0001))
	} // enf of body
	
}

struct CoinRowComponent_Previews: PreviewProvider {
	static var previews: some View {
		CoinRowComponent(coin: DummyData.coin , showHoldingsColumn: true)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.light)
	}
}
