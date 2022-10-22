//
//  View.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 16/10/22.
//

import Foundation
import SwiftUI

extension View {
	func withoutAnimation() -> some View {
		self.animation(nil, value: UUID())
	}
}
