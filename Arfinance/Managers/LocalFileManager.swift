//
//  FileManager.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 19/10/22.
//

import Foundation
import SwiftUI

class LocalFileManager {
	
	static let instance = LocalFileManager() ;
	private init () {}
	
	private var url : URL? ;
	
	func setURL (_ urlStr : String) {
		self.url = URL(string: urlStr)
	}
	
	func save (image : UIImage , imageName : String , dirName : String) {
		
		self.makeDirectoryIfNeeded(dirName: dirName) ;
		
		guard
			let data = image.pngData() ,
			let url = self.getURLForImage(imageName: imageName, dirName: dirName)
		else { return }
		
		do {
			try data.write(to: url)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func get (imageName : String , dirName : String) -> UIImage? {
		guard
			let url = self.getURLForImage(imageName: imageName, dirName: dirName) ,
			FileManager.default.fileExists(atPath: url.path)
		else { return nil}
		
		return UIImage(contentsOfFile: url.path) ;
	}
	
	private func makeDirectoryIfNeeded (dirName : String) -> () {
		guard let url = self.getURLForDirectory(dirName: dirName) else { return }
		
		if (FileManager.default.fileExists(atPath: url.path) == false) {
			do {
				try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
			} catch  {
				print(error.localizedDescription)
			}
		}
	}
	
	private func getURLForDirectory (dirName : String) -> URL? {
		guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
		return url.appendingPathComponent(dirName)
	}
	
	private func getURLForImage (imageName : String , dirName : String) -> URL? {
		guard let directoryURL = self.getURLForDirectory(dirName: dirName) else {return nil}
		return directoryURL.appendingPathComponent(imageName + ".png")
	}
	
}
