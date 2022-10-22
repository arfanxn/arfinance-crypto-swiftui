//
//  HomeHeaderComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import SwiftUI

struct HomeHeaderComponent: View {
	@EnvironmentObject private var vm : HomeVM ;
	
	var body: some View {
		HStack{
			CircleButtonComponent(iconName: self.vm.showPortfolio ? "plus" : "info" , animate: self.$vm.showPortfolio)
				.sheet(isPresented: self.$vm.showPortfolioSheet, content: {
					UpdateCoinPortfolioComponent()
				})
				.onTapGesture {
					if (self.vm.showPortfolio) {
						self.vm.showPortfolioSheet.toggle()
					}
				}
			Spacer()
			Text(self.vm.showPortfolio ? "Portfolio" : "Live Prices")
				.withoutAnimation()
				.font(.headline)
				.fontWeight(.heavy)
				.foregroundColor(.theme.accent)
			Spacer()
			CircleButtonComponent(iconName: "chevron.right" , animate: self.$vm.showPortfolio)
				.rotationEffect(.degrees(self.vm.showPortfolio ? 180 : 00 ))
				.onTapGesture {
					withAnimation(.spring()) {
						self.vm.showPortfolio.toggle()
					}
				}
			
		}
	}
}

struct HomeHeaderComponent_Previews: PreviewProvider {
	static var previews: some View {
		HomeHeaderComponent().environmentObject(HomeVM())
			.previewLayout(.sizeThatFits)
	}
}
