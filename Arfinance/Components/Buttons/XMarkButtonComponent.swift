//
//  XButtonComponent.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 20/10/22.
//

import SwiftUI

struct XButtonComponent: View {
	@Environment(\.presentationMode) var presentationMode ;
	
	var body: some View {
		Button(action: {
			self.presentationMode.wrappedValue.dismiss()
		}, label: {
			Image(systemName: "xmark")
				.font(.headline)
		})
	}
}

struct XButtonComponent_Previews: PreviewProvider {
	static var previews: some View {
		XButtonComponent()
	}
}
