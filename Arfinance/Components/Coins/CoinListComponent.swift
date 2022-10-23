//
//  CoinListComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 21/10/22.
//

import SwiftUI

struct CoinListComponent: View {
	
	@Binding var coins : [Coin] ;
	var axis : AxisEnum = .vertical
	var showHoldingColumn : Bool = false
	let onClick : (_ coin : Coin) -> () ;
	@State private var selectedCoin : Coin?
	
	var body: some View {
		if (self.axis == .vertical) {
			List{
				ForEach(self.coins , id: \.id) { coin in
					CoinRowComponent(coin: coin , showHoldingColumn: self.showHoldingColumn)
						.listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
						.onTapGesture(perform: {
							withAnimation(.easeIn) {
								self.selectedCoin = coin
							}
							self.onClick(coin)
						})
				}
			}
			.listStyle(.plain)
		} else {
			ScrollView(.horizontal , showsIndicators: false ,content: {
				LazyHStack(spacing: 10) {
					ForEach(self.coins) { coin in
						VStack{
							CoinLogoComponent(coin: coin)
								.frame(width: .infinity , height: .infinity)
								.onTapGesture {
									withAnimation(.easeIn) {
										self.selectedCoin = coin
									}
									self.onClick(coin);
								}
							Text("\(coin.name)")
						}
						.padding(.all,4)
						.background(
							RoundedRectangle(cornerRadius: 10)
								.stroke(
									self.selectedCoin?.id == coin.id ? Color.theme.green
									: Color.clear,
									lineWidth: 1
								)
						)
					}
				}
				.frame(height: 100)
			})
		}
	}
}

struct CoinListComponent_Previews: PreviewProvider {
	static var previews: some View {
		CoinListComponent(coins: .constant([DummyData.coin])
						  , axis : .horizontal) { coin in
		}
	}
}
