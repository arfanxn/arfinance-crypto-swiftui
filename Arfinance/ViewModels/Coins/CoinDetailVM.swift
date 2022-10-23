//
//  CoinDetailVM.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import Foundation

class CoinDetailVM : ObservableObject {
	
	@Published var coinDetail : CoinDetail? = nil
	@Published var coinOverviews : [CoinStatistic<String>] = [] ;

	public func getCoinDetail (coin : Coin) async -> CoinDetail? {
		if self.coinDetail != nil {
			return self.coinDetail
		}
		
		guard let coinDetail = await CoinService.init().fetchDetail(coin:coin) else {return nil}
		await MainActor.run(body: {
		self.coinDetail = coinDetail ;
		self.coinOverviews = coinDetail.getOverviews() ;
		})
		
		return coinDetail
	}
}
