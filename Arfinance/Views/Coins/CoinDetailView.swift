//
//  CoinDetailView.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import SwiftUI

struct CoinDetailView: View {
	
	@StateObject var vm : CoinDetailVM = .init();
	@Binding var coin : Coin? ;
	
	
	var body: some View {
		Group {
			if self.$coin.wrappedValue != nil {
				self.coinDetailView
			} else {
				EmptyView()
			}
		}
	}
	
	var coinDetailView : some View {
		ScrollView{
			VStack( alignment: .leading ,spacing: 20 ){
				Text(self.coin!.name)
					.font(.largeTitle)
					.fontWeight(.bold)
				
				Text("Overviews")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(.theme.accent)
				
				Divider()
				
				LazyVGrid(
					columns: [
						GridItem(.flexible()) ,
						GridItem(.flexible()) ,
					],
					alignment: .leading,
					spacing: 30,
					pinnedViews: [],
					content: {
						if let overviews =  self.vm.coinOverviews {
							ForEach(overviews) { overview in
								CoinStatisticComponent(stat: overview )
							}
						}
					}
				)
				.task {
					if let coin = self.$coin.wrappedValue {
						_ = await self.vm.getCoinDetail(coin: coin) ;
					}
				}
				
				Text("Additional details")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(.theme.accent)
					.frame(maxWidth: .infinity , alignment: .leading)
				
				Divider()
				
				LazyVGrid(
					columns: [
						GridItem(.flexible()) ,
						GridItem(.flexible()) ,
					],
					alignment: .leading,
					spacing: 30,
					pinnedViews: [],
					content: {
						ForEach(self.vm.coinAdditionals) { additional in
							CoinStatisticComponent(stat: additional )
						}
					}
				)
				
			}
			.padding(.all)
		}
		.navigationTitle(self.coin!.name)
	}
}

struct CoinDetailView_Previews: PreviewProvider {
	static var previews: some View {
		CoinDetailView(coin: .constant(DummyData.coin))
	}
}
