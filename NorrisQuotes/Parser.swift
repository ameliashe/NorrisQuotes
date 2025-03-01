//
//  Parser.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import Foundation

final class Parser {
	static func decodeQuote(_ data: Data) -> Quote? {
		do {
			let answer = try JSONDecoder().decode(Quote.self, from: data)
			return answer
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}
}
