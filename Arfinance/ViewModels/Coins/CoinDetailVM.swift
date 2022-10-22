//
//  CoinDetailVM.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import Foundation

class CoinDetailVM : ObservableObject {
	
	@Published var coin : Coin
	@Published var coinDetail : CoinDetail? = nil
	@Published var coinOverviews : [CoinStatistic<String>] = [] ;
	
	init(coin: Coin) {
		self.coin = coin
	}
		
	public func getCoinDetail () async -> CoinDetail? {
		if self.coinDetail != nil {
			return self.coinDetail
		}
		
		guard let coinDetail = await CoinService.init().fetchDetail(coin:self.coin) else {return nil}
		await MainActor.run(body: {
			self.coinDetail = coinDetail ;
			self.coinOverviews = coinDetail.getOverviews() ;
			print(coinDetail.getOverviews())
		})
		
		return coinDetail
	}
}
