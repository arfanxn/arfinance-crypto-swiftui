//
//  CoinDetailVM.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import Foundation

class CoinDetailVM : ObservableObject {
	
	@Published var coinDetail : CoinDetail? = nil
		
	public func getCoinDetail (coin : Coin) async -> CoinDetail? {
		if self.coinDetail != nil {
			return self.coinDetail
		}
		
		return await CoinService.init().fetchDetail(coin:coin);
	}
}
