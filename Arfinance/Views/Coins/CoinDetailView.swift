//
//  CoinDetailView.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import SwiftUI

struct CoinDetailView: View {
	
	@StateObject var vm : CoinDetailVM = .init();
	@Environment(\.presentationMode) var presentationMode ;
	@Binding var coin : Coin? ;
	@State private var showCoinFullDescription : Bool = false ;
	
	
	var body: some View {
		NavigationStack {
			if self.$coin.wrappedValue != nil {
				self.coinDetailView
			} else {
				EmptyView()
			}
		}
	}
	
	var coinDetailView : some View {
		ScrollView{
			VStack(alignment: .leading , spacing: 10){
				Text("\(self.coin!.name)")
					.font(.largeTitle)
					.fontWeight(.bold)
					.foregroundColor(.theme.accent)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.all)
			
			CoinChartComponent(coin: coin!)
				.frame(height: 250)
			
			VStack( alignment: .leading ,spacing: 20 ){
				
				Text("Overviews")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(.theme.accent)
				
				Divider()
				
				
				if let coinDescription = self.vm.coinDetail?.description?.en?.removeHTMLOccurances , coinDescription.isEmpty == false {
					VStack(alignment: .leading){
						Text(coinDescription)
							.lineLimit(self.showCoinFullDescription ? nil : 3)
							.foregroundColor(.theme.secondaryText)
							.font(.callout)
						
						Button {
							withAnimation {
								self.showCoinFullDescription.toggle()
							}
						} label: {
							Text(self.showCoinFullDescription == false ? "Read more..." : "Less")
								.font(.caption)
								.fontWeight(.bold)
								.padding(.vertical, 4)
						}
						.accentColor(.blue)
						
					}
				}
								
				LazyVGrid(
					columns: [
						GridItem(.flexible()) ,
						GridItem(.flexible()) ,
					],
					alignment: .leading,
					spacing: 30,
					pinnedViews: [],
					content: {
						if let overviews =  self.vm.coinDetail?.overviews {
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
						if let addtionals = self.vm.coinDetail?.addtionals {
							ForEach(addtionals) { additional in
								CoinStatisticComponent(stat: additional )
							}
						}
					}
				)
				
				VStack(alignment: .leading , spacing: 20){
					if let coinWebsiteURL = URL(string : self.vm.coinDetail?.links?.homepage?.first ?? "") {
						Link("Website", destination: coinWebsiteURL)
					}
					if let coinSubRedditURL = URL(string : self.vm.coinDetail?.links?.subredditURL ?? "") {
						Link("Reddit", destination: coinSubRedditURL)
					}
				}
				.accentColor(.blue)
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.headline)
				
			}
			.padding(.all)
		}
		//		.navigationBarTitle(self.coin!.name)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button(action: {
					self.presentationMode.wrappedValue.dismiss()
				}, label: {
					Image(systemName: "xmark")
						.font(.headline)
				})
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				HStack{
					Text(self.coin!.symbol.uppercased())
						.font(.headline)
						.foregroundColor(.theme.secondaryText)
					CoinLogoComponent(coin: self.coin!)
						.frame(width: 25 , height: 25)
				}
			}
		}
	}
}

struct CoinDetailView_Previews: PreviewProvider {
	static var previews: some View {
		CoinDetailView(coin: .constant(DummyData.coin))
	}
}
