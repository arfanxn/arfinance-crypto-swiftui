//
//  AboutView.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 24/10/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
		NavigationStack{
			List{
				Section(header: Text("Developer Info")) {
					VStack(alignment: .leading) {
						Image("logo")
							.resizable()
							.frame(width: 100 , height: 100)
							.clipShape(RoundedRectangle(cornerRadius: 20))
						Text("Build with Love by \"Arfanxn\"")
							.font(.headline)
						Text("Stack : SwiftUI, MVVM Architecture , Coingecko API ,Async await and Combine Library")
							.font(.caption)
					}
					.foregroundColor(.theme.accent)
					.padding(.vertical)
					Link("Github" , destination: URL(string: "https://github.com/arfanxn")!)
					Link("Linkedin", destination: URL(string: "https://linkedin.com/in/arfanxn")!)
					Link("Portfolio" , destination: URL(string: "https://arfanxn.github.io")!)
				}
				.accentColor(.blue)
			}
			.navigationTitle("About")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					XButtonComponent()
				}
			}
		}
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
