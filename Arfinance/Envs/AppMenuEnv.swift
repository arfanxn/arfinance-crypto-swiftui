//
//  AppMenuEnv.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 27/10/22.
//

import SwiftUI

private struct AppMenuEnvKey: EnvironmentKey {
	static let defaultValue : AppMenuEnum = .home
}

extension EnvironmentValues {
	var currentMenu: AppMenuEnum {
		get { self[AppMenuEnvKey.self] }
		set { self[AppMenuEnvKey.self] = newValue }
	}
}
