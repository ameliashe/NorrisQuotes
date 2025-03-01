//
//  QuotesManager.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import Foundation
import RealmSwift

final class QuotesManager {

	var quotes: [Quote] = []

	init() {
		let config = Realm.Configuration(schemaVersion: 1)
		Realm.Configuration.defaultConfiguration = config
		self.quotes = fetchQuotes()
	}

	func addQuote(_ quote: Quote) {
		let realm = try! Realm()

		try! realm.write {
			realm.add(quote)
		}
		quotes = fetchQuotes()
	}

	func fetchQuotes() -> [Quote] {
		let realm = try! Realm()

		let results = realm.objects(Quote.self).sorted(byKeyPath: "date", ascending: false)
		return results.map { $0 }
	}

	func loadCategories() -> [String] {
		quotes = fetchQuotes()
		let allCategories = quotes.flatMap { $0.categories }
		let uniqueCategories = Set(allCategories)
		return Array(uniqueCategories).sorted()
	}
}
