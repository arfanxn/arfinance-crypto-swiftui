//
//  CoinLogoComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 19/10/22.
//

import SwiftUI


struct CoinLogoComponent: View {
	
	let coin : Coin ;
	@State var coinLogo : UIImage? = nil ;
	
	var body: some View {
		ZStack{
			if let logo = self.coinLogo {
				Image(uiImage: logo)
					.resizable()
					.scaledToFit()
			} else if self.coinLogo == nil {
				ProgressView()
			} else {
				Image(systemName: "questionmark")
					.foregroundColor(.theme.secondaryText)
			}
		}
		.task {
			let logo = await CoinService.init().fetchLogo(url: URL(string: coin.logoUrl)!)
			await MainActor.run {
				self.coinLogo = logo
			}
		}
	}
}

struct CoinLogoComponent_Previews: PreviewProvider {
	static var previews: some View {
		CoinLogoComponent(coin: DummyData.coin)
			.previewLayout(.sizeThatFits)
	}
}
