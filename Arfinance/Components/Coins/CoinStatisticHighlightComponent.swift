//
//  HomeStatsComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 19/10/22.
//

import SwiftUI

struct CoinStatisticHighlightComponent: View {
	
	@Binding var coinStatistics : [CoinStatistic<String>]
		
	var body: some View {
		ScrollView( .horizontal , showsIndicators: false) {
			HStack{
				ForEach(self.coinStatistics) { stat in
					CoinStatisticComponent(stat: stat)
						.frame(width: UIScreen.main.bounds.width / 3)
				}
			}
			.frame(
				alignment: .leading
			)
		}
	}
}

struct CoinStatisticHighlightComponent_Previews: PreviewProvider {
	static var previews: some View {
		CoinStatisticHighlightComponent(coinStatistics: .constant(
			DummyData.coinStatistics
		))
	}
}
