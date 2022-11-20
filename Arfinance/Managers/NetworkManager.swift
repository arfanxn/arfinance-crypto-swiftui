//
//  NetworkingManager.swift
//  Arfinance
//
//  Created by Muhammad Arfan on 19/10/22.
//

import Foundation
import Combine

class NetworkManager {
	
	enum Errors : LocalizedError {
		case badURLResponse(url : URL)
		case unknown
		
		var errorDescription: String? {
			switch self {
				case .badURLResponse(url: let url ) : return "Bad URL from \(url)"
				case .unknown : return "Unkown Error"
			}
		}
	}
	
	
	static func request (url : URL) ->
	AnyPublisher<Data, Error> {
		return URLSession.shared.dataTaskPublisher(for: url)
			.subscribe( on: DispatchQueue.global(qos: .default) )
			.tryMap({ try self.handleURLResponse($0 , url: url) })
			.eraseToAnyPublisher()
	}
	
	static func handleURLResponse (_ output : URLSession.DataTaskPublisher.Output , url : URL) throws -> Data{
		guard let response = output.response as? HTTPURLResponse ,
			  response.statusCode >= 200 && response.statusCode < 300
		else {
			throw self.Errors.badURLResponse(url: url)
		}
		return output.data;
	}
	
	static func handleCompletion (completion : Subscribers.Completion<Error>) -> () {
		switch completion {
			case .finished :
				break;
			case .failure(let error) :
				print(error.localizedDescription);
				break;
		}
	}
}
