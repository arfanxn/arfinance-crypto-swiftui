//
//  CoinLogoComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 20/10/22.
//

import SwiftUI

struct CoinSymbolComponent: View {
	
	let coin : Coin ;
	
	var body: some View {
		VStack{
			CoinLogoComponent(coin: self.coin)
				.frame(width: 50 , height: 50)
			Text(self.coin.symbol.uppercased())
				.font(.headline)
				.foregroundColor(.theme.accent)
				.lineLimit(1)
				.minimumScaleFactor(0.5)
			Text("\(self.coin.name)")
				.font(.caption)
				.foregroundColor(.theme.secondaryText)
				.lineLimit(2)
				.minimumScaleFactor(0.5)
				.multilineTextAlignment(.center)
			
		}
	}
}

struct CoinSymbolComponent_Previews: PreviewProvider {
	static var previews: some View {
		CoinLogoComponent(coin: DummyData.coin)
	}
}
