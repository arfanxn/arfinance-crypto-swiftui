//
//  CircleButtonComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 16/10/22.
//

import SwiftUI

struct CircleButtonComponent: View {
	var iconName : String = "info";
	@Binding var animate : Bool ;
	
	var body: some View {
		Image(systemName: self.iconName)
			.font(.headline)
			.foregroundColor(.theme.accent)
			.frame(width: 50,height: 50)
			.background(
				Circle()
					.stroke(lineWidth: 5.0)
					.scale(self.animate ? 1.0 : 0.0)
					.opacity(self.animate ? 0.0 : 1.0)
					.animation(self.animate ? .easeOut(duration: 1.0) : .easeOut(duration: 00) , value: UUID())
					.foregroundColor(.theme.accent)
			)
			.shadow(color: .theme.accent.opacity(0.5),
					radius: 10 ,
					x: 0 , y: 0
			)
			.padding(.all)
		
	}
}

struct CircleButtonComponent_Previews: PreviewProvider {
	static var previews: some View {
		Group{
			CircleButtonComponent(animate: .constant(true))
			
				.padding()
				.previewLayout(.sizeThatFits)
			
			CircleButtonComponent(iconName: "flame.fill" , animate: .constant(false))
				.padding()
				.previewLayout(.sizeThatFits)
				.colorScheme(.dark)
			
		}
	}
}
