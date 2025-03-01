//
//  NetworkService.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import Foundation

final class NetworkService {
	
	enum RequestError: Error {
		case error(Error)
		case dataIsNil
		case errorAnswerCode
	}

	static func request(from url: URL, completion: @escaping (Result<Data, RequestError>) -> Void) {

		let session = URLSession.shared
		let task = session.dataTask(with: url) { data, response, error in
			if error != nil {
				completion(.failure(.error(error!)))
				return
			}

			if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
				completion(.failure(.errorAnswerCode))
				return
			}

			guard let data = data else {
				completion(.failure(.dataIsNil))
				return
			}

			completion(.success(data))
		}
		task.resume()
	}
}
