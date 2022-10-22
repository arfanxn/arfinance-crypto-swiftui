//
//  StatisticModel.swift
//  SwiftfulCrypto
//
//  Created by Nick Sarno on 5/9/21.
//

import Foundation

struct CoinStatistic<Value>: Identifiable {
	let id = UUID().uuidString
	let title: String
	let value: Value
	let percentageChange: Double?
	
	init(title: String, value: Value, percentageChange: Double? = nil) {
		self.title = title
		self.value = value
		self.percentageChange = percentageChange
	}
}
