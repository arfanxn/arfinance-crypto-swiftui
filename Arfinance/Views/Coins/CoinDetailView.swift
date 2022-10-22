//
//  CoinDetailView.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import SwiftUI

struct CoinDetailView: View {
	
	@StateObject var vm : CoinDetailVM ;
	
	init(coin: Coin) {
		_vm = StateObject(wrappedValue: CoinDetailVM(coin : coin))
	}
	
    var body: some View {
		ScrollView{
			VStack( alignment: .leading ,spacing: 20 ){
				Text("\(self.vm.coin.name)")
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
					_ = await self.vm.getCoinDetail()
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
//						ForEach(self.vm.coinAdditionals) { additional in
//							StatisticComponent(stat: additional )
//						}
					}
				)
				
			}
			.padding(.all)
		}
		.navigationTitle(self.vm.coin.name)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
		CoinDetailView(coin: DummyData.coin)
    }
}
