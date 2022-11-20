//
//  ArfinanceApp.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 22/10/22.
//

import SwiftUI

@main
struct ArfinanceApp: App {
	
	@StateObject var vm = HomeVM() ;
	@State var showLaunchView = true ;
	
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(.theme.accent)]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(.theme.accent)]
		UITableView.appearance().backgroundColor = UIColor.clear
	}

    var body: some Scene {
        WindowGroup {
			ZStack{
				NavigationView(content: {
					HomeView()
						.environmentObject(self.vm)
				})
				.navigationViewStyle(.stack)
				
				LaunchView(show: self.$showLaunchView)
			}
        }
    }
}
