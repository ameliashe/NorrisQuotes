//
//  Model.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import Foundation
import RealmSwift

class Quote: Object, Codable {
	@Persisted var categories = List<String>()
	@Persisted var createdAt: String
	@Persisted var id: String
	@Persisted var updatedAt: String
	@Persisted var url: String
	@Persisted var value: String
	@Persisted var date = Date()

	enum CodingKeys: String, CodingKey {
		case categories
		case createdAt = "created_at"
		case id
		case updatedAt = "updated_at"
		case url
		case value
	}
}
