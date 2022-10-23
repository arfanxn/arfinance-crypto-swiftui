//
//  HomeVM.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 16/10/22.
//

import Foundation
import Combine

class HomeVM : ObservableObject {
	
	@Published var coinStatistics : [CoinStatistic<String>] = []
	
	@Published var keyword : String = "" ;
	@Published var coinSortOption : CoinSortOptionEnum = .holdingHighest;
	
	@Published var coins : [Coin] = [] ;
	@Published var portfolioCoins : [Coin] = [] ;
	
	@Published var showPortfolio = false ;
	@Published var showPortfolioSheet = false ;
	
	let coinService = CoinService();
	let coinPortfolioService = CoinPortfolioService() ;
	
	init () {
		self.subscribeAndFetch()
	}
	
	public func updateCoinPortfolio (coin : Coin , holding : Double) {
		self.coinPortfolioService.update(coin: coin, holding: holding)
	}

	private func subscribeAndFetch () {
		self.$keyword.combineLatest(self.coinService.$collection , self.$coinSortOption)
			.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
			.map { (keyword , coins , sortOption : CoinSortOptionEnum) -> (coins : [Coin] , portfolioCoins : [Coin] ) in
				let coins = coins.filter({ coin -> Bool in
					let keyword = keyword.lowercased();
					return keyword.isEmpty == false ? (
						coin.name.lowercased().contains(keyword) ||
						coin.symbol.lowercased().contains(keyword) ||
						coin.id.lowercased().contains(keyword)
					) : true ;
				})
					.sorted(by: { (prev:Coin , next:Coin) in
						switch sortOption {
							case .rankLowest :
								return prev.rank > next.rank
							case .priceHighest :
								return prev.currentPrice > next.currentPrice
							case .priceLowest :
								return prev.currentPrice < next.currentPrice
							case .holdingLowest :
								return prev.currentHoldingValue > next.currentHoldingValue
							case .holdingHighest :
								return prev.currentHoldingValue < next.currentHoldingValue
							default :
								return prev.rank < next.rank
						}
					})
				
				let portfolioCoins : [Coin] = coins.filter({ $0.currentHoldingValue > 0 });
				
				return (
					coins : coins ,
					portfolioCoins : portfolioCoins
				)
			}
			.sink {[weak self] (coins , portfolioCoins) in
				self?.coins = coins
			}
			.store(in: &CombineCancellable.cancellables)
		
		
		
		self.$coins.combineLatest(self.coinPortfolioService.$collection)
			.map{(coins, coinPortfolios) -> [Coin] in
				return coins.compactMap { (coin) -> Coin? in
					guard let coinPortfolio = coinPortfolios.first(where: {$0.coinID  == coin.id }) else {
						return nil ;
					};
					return coin.updateHolding(amount: coinPortfolio.holding) ; // returned a portfolio coin
				} // returned portfolio coins
			}
			.sink {[weak self] (coins) in
				guard let self = self else {return}

				self.portfolioCoins = coins
			
				Task{
					if self.coinStatistics.isEmpty == false {
						return
					}
					guard let coinMarket = await self.coinService.fetchMarket() else {
						return
					}
					
					// Retrive the portfolio coins
					let coins = self.portfolioCoins ;
					
					print(coins.count); 
										
					// Portfolio
					let portfolioValue = coins.map { $0.currentHoldingValue }.reduce(0, +)
					let prevPortfolioValue = coins.map { (coin) -> Double in
						let currentHolding = coin.currentHoldingValue ;
						let percentChage = (Double(coin.priceChangePercentage24H ?? 0 )) / 100;
						return currentHolding / (1 + percentChage) ;
					}.reduce(0, +)
					let portfolioPercentageChange = ((portfolioValue - prevPortfolioValue) / prevPortfolioValue) * 100
					// End Portfolio
					
					await MainActor.run {
						self.coinStatistics = [
							CoinStatistic(title:  "Market cap", value: coinMarket.marketCap , percentageChange:  coinMarket.marketCapChangePercentage24HUsd),
							CoinStatistic(title: "24H Volume", value: coinMarket.volume),
							CoinStatistic(title: "Btc Dominance", value: coinMarket.btcDominance),
							CoinStatistic (title: "Portfolio Value", value: "$0.00" , percentageChange: portfolioPercentageChange) // Store Portfolio percentage change
						];
					}
				}
			}
			.store(in: &CombineCancellable.cancellables)
			
	}
}
