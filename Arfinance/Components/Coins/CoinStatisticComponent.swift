//
//  CoinStatisticComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 19/10/22.
//

import SwiftUI

struct CoinStatisticComponent: View {
	
	let stat : CoinStatistic<String> ;
	
	var body: some View {
		VStack(alignment: .leading , spacing: 4) {
			Text("\(stat.title)")
				.foregroundColor(.theme.secondaryText)
			Text("\(stat.value)")
				.foregroundColor(.theme.accent)
			HStack(spacing: 4){
				Image(systemName: "triangle.fill")
					.font(.caption2)
					.rotationEffect(
						.degrees((self.stat.percentageChange ?? 0) >= 0 ? 0 : 180)
					)
				Text("\(stat.percentageChange?.asPercentString() ?? "")")
					.font(.caption)
					.bold()
			}
			.foregroundColor((self.stat.percentageChange ?? 0) >= 0 ? .theme.green : .theme.red )
			.opacity(self.stat.percentageChange == nil ? 0.0 : 1.0)
		}
	}
}

struct CoinStatisticComponent_Previews: PreviewProvider {
	static var previews: some View {
		HStack(spacing : 2) {
			CoinStatisticComponent(stat: DummyData.coinStatistics.first!)
			CoinStatisticComponent(stat: DummyData.coinStatistics.last!)
		}
	}
}
