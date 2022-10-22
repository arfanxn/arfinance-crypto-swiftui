//
//  API.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import Foundation


class API {
	class Coin {
		static let data = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
		
		static let globalMarket = "https://api.coingecko.com/api/v3/global"
	}
}
