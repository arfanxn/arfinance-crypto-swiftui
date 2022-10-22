//
//  CoinListComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 21/10/22.
//

import SwiftUI

struct CoinListComponent: View {
	
	@Binding var coins : [Coin] ;
	let onClick : (_ coin : Coin) -> () ;
	
	var body: some View {
		List{
			ForEach(self.coins) { coin in
				CoinRowComponent(coin: coin)
					.listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
					.onTapGesture(perform: {
						self.onClick(coin)
					})
			}
		}
		.listStyle(.plain)
	}
}

struct CoinListComponent_Previews: PreviewProvider {
	static var previews: some View {
		Text("CoinListComponent")
	}
}
