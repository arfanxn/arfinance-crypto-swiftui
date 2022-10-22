//
//  SearchBarComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 19/10/22.
//

import SwiftUI

struct SearchBarComponent: View {
	
	@Binding var keyword : String;
	
	var body: some View {
		HStack{
			Image(systemName: "magnifyingglass")
				.foregroundColor(self.keyword.isEmpty ? .theme.secondaryText : .theme.accent)
			TextField("Search by name or symbol..." , text: self.$keyword)
				.foregroundColor(.theme.accent)
				.disableAutocorrection(true)
				.overlay(
					Image(systemName: "xmark.circle.fill")
						.padding(.all)
						.offset(x: 10)
						.foregroundColor(.theme.accent)
						.opacity(self.keyword.isEmpty ? 0.0 : 1.0)
						.onTapGesture {
							withAnimation(.spring()) {
								UIApplication.shared.endEditing()
								self.keyword = "" ;
							}
						}
					,alignment: .trailing
				)
		}
		.font(.headline)
		.padding(.all)
		.background(
			RoundedRectangle(cornerRadius: 25)
				.fill(Color.theme.background)
				.shadow(color: .theme.accent.opacity(0.15), radius: 10)
		)
	}
}

struct SearchBarComponent_Previews: PreviewProvider {
	static var previews: some View {
		SearchBarComponent(keyword: .constant(""))
			.previewLayout(.sizeThatFits)
	}
}
