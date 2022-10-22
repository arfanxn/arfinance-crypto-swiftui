//
//  CoinMarketComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 21/10/22.
//

import SwiftUI

struct SortButtonComponent: View {
	
	@Binding var showChevron : Bool ;
	@Binding var chevronDirection : ChevronDirectionEnum ;
	@State var rotationDegrees : Double? ;
	
	let title : String ;
	let onClick : (_ chevronDirection : ChevronDirectionEnum) -> () ;
	
	
	init(
		title : String ,
		showChevron : Binding<Bool> = .constant(true),
		chevronDirection: Binding<ChevronDirectionEnum> = .constant(.up),
		onClick : @escaping (_ chevronDirection : ChevronDirectionEnum) -> ()
	) {
		_showChevron = showChevron
		_chevronDirection = chevronDirection
		self.title = title
		self.onClick = onClick
	}
	
	var body: some View {
		HStack{
			Text(self.title)
			Image(systemName: "chevron.up")
				.opacity(
					self.showChevron ? 1.0 : 0.0
				)
				.rotationEffect(
					.degrees(
						self.chevronDirection == ChevronDirectionEnum.up ? 0 : 180
					)
				)
		}
		.onTapGesture(perform: {
			withAnimation {
				self.chevronDirection = self.chevronDirection == ChevronDirectionEnum.up ?
				ChevronDirectionEnum.down : ChevronDirectionEnum.up ;
			}
			self.onClick(self.chevronDirection)
		})
	}
}

struct SortButtonComponent_Previews: PreviewProvider {
	static var previews: some View {
		Text("CoinSorterComponent")
	}
}
