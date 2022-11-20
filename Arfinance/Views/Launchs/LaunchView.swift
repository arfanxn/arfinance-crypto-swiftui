//
//  LaunchView.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 27/10/22.
//

import SwiftUI

struct LaunchView: View {
	
	@Binding var show : Bool ;
	
	private let loadingText = "Loading...".map({String($0)}) ;
	private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect();
	private let maxLoop : Int = 7;
	@State private var currentLoop : Int = 0;
	@State private var showLoadingText : Bool = false ;
	@State private var counter : Int = 0 ;
	
    var body: some View {
		if self.show {
			ZStack{
				Color.theme.background
					.ignoresSafeArea(.all)
				Image("logo-transparent")
					.resizable()
					.frame(width: 100 , height: 100 , alignment: .center)
					.padding(30)
					.overlay(alignment: .bottom, content: {
						if self.showLoadingText {
							HStack(spacing: .zero){
								ForEach(self.loadingText.indices) { index in
									Text("\(self.loadingText[index])")
										.font(.headline)
										.fontWeight(.heavy)
										.foregroundColor(.theme.accent)
										.transition(.scale.animation(.easeIn))
										.offset(y: self.counter == index ? -5 : .zero)
								}
							}
						}
					})
			}
			.onAppear{
				self.showLoadingText.toggle()
			}
			.onReceive(self.timer) { output in
				withAnimation(.spring()) {
					switch true {
						case self.currentLoop == self.maxLoop :
							self.show = false ;
							self.timer.upstream.connect().cancel()
							break ;
						case self.counter == self.loadingText.count :
							self.counter = 0
							self.currentLoop += 1
							break ;
						default :
							self.counter += 1
							break ;
					}
				}
			}
			.transition(.move(edge: .leading))
			.zIndex(9999)
			
		} // "if" closing curly bracket
    } // "body" closing curly bracket
}
 
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
		LaunchView(show: .constant(true))
    }
}
