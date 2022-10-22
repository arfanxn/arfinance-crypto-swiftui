//
//  CoinPortfolioService.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import Foundation
import CoreData

class CoinPortfolioService {
	private let container : NSPersistentContainer ;
	private let containerName : String = "CoinPortfolio" ;
	private let entityName : String = "CoinPortfolio" ;
	
	@Published var collection : [CoinPortfolio] = []
	
	init() {
		self.container = NSPersistentContainer(name: self.containerName) ;
		self.container.loadPersistentStores { (_, error) in
			if let error = error {
				print(error.localizedDescription) ;
			}
			
			self.fetch()
		}
	}
	
	private func fetch () {
		let request = NSFetchRequest<CoinPortfolio>(entityName : self.entityName) ;
		
		do {
			self.collection = try self.container.viewContext.fetch(request) ;
		} catch let error {
			print(error.localizedDescription)
		}
	}
	
	public func store (coin : Coin , holding : Double ) {
		let coinPortfolio = CoinPortfolio(context: self.container.viewContext);
		coinPortfolio.coinID = coin.id ;
		coinPortfolio.holding = holding ;
		
		self.save()
	}
	
	public func update (coinPortfolio : CoinPortfolio , holding : Double) {
		switch true {
			case holding > 0 :
				coinPortfolio.holding = holding
				self.save() ;
			default :
				self.delete(coinPortfolio) ;
		}
	}
	
	public func update (coin : Coin , holding : Double) {
		if let coinPortfolio = self.collection.first(where: {$0.coinID == coin.id}) {
			switch true {
				case holding > 0 :
					coinPortfolio.holding = holding
					self.save() ;
				default :
					self.delete(coinPortfolio) ;
			}
		} else {
			self.store(coin: coin, holding: holding)
		}
	}
	
	public func delete (_ coinPortfolio : CoinPortfolio) {
		self.container.viewContext.delete(coinPortfolio)
		
	}
	
	private func save () {
		do {
			try self.container.viewContext.save()
			self.fetch()
		} catch let error {
			print(error.localizedDescription)
		}
	}
	
}
