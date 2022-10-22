//
//  UpdateCoinPortfolioComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 20/10/22.
//

import SwiftUI

struct UpdateCoinPortfolioComponent: View {
	
	@EnvironmentObject private var vm : HomeVM ;
	@Environment(\.presentationMode) var presentationMode ;
	
	@State private var selectedCoin : Coin? = nil ;
	@State private var coinQty : String = "" ;
	@State private var showCheckmark : Bool = false ;
	
	var body: some View {
		NavigationView {
			ScrollView{
				VStack(alignment: .leading, spacing: 0){
					SearchBarComponent(keyword: self.$vm.keyword)
						.onChange(of: self.vm.keyword) { newValue in
							self.selectedCoin = nil
						}
					
					CoinListComponent(coins: self.vm.keyword.isEmpty ? self.$vm.portfolioCoins : self.$vm.coins
									, axis : .horizontal) { coin in
							withAnimation(.easeIn) {
								self.selectedCoin = coin ;
								
								if let portfolioCoin = self.vm.portfolioCoins.first(where: { $0.id == coin.id }),
								   let amount = portfolioCoin.currentHoldings  {
									self.coinQty = "\(amount)"
								} else {
									self.coinQty = ""
								}
							}
					}
					
					if let coin = self.selectedCoin {
						VStack{
							HStack{
								Text("Current price of \(coin.symbol.uppercased()) : ")
								Spacer()
								Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
							}
							Divider()
							HStack{
								Text("Amount in your portfolio: ")
								Spacer()
								TextField("Ex : 1.4", text : self.$coinQty )
									.keyboardType(.decimalPad)
									.multilineTextAlignment(.trailing)
							}
							Divider()
							HStack{
								Text("Current Holdings :")
								Text(
									(
										(Double(self.coinQty) ?? 0) * (coin.currentPrice)
									).asCurrencyWith2Decimals()
								)
							}
						}
						.withoutAnimation()
						.padding()
						.font(.headline)
					}
				}
			}
			.navigationTitle("Edit portfolio")
			.toolbar(content: {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {
						self.presentationMode.wrappedValue.dismiss()
					}, label: {
						Image(systemName: "xmark")
							.font(.headline)
					})
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					Group{
						if self.showCheckmark {
							Image(systemName: "checkmark")
						} else {
							Button {
								save()
							} label: {
								Text("Save".uppercased())
							}
						}
					}
					.font(.headline)
				}
			})
		}
	}
	
	private func save () {
		guard let coin = self.selectedCoin else {return}
		
		withAnimation(.easeIn) {
			self.showCheckmark = true
			self.selectedCoin = nil
			self.vm.keyword = "" ;
			// hide keyboard
			UIApplication.shared.endEditing()
		}
		
		self.vm.updateCoinPortfolio(coin: coin, holding: Double(self.coinQty) ?? 0)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			withAnimation(.easeInOut) {
				self.showCheckmark = false ;
//				self.presentationMode.wrappedValue.dismiss()
			}
		})
	}
}

struct UpdateCoinPortfolioComponent_Previews: PreviewProvider {
	static var previews: some View {
		Text("Hello")
	}
}
