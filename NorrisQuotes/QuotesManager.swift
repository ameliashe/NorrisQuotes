//
//  QuotesManager.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import Foundation
import RealmSwift
import KeychainSwift

final class QuotesManager {

	var quotes: [Quote] = []
	lazy var encryptionKey = getEncryptionKey()
	lazy var config = Realm.Configuration(encryptionKey: encryptionKey, schemaVersion: 1)

	init() {
		Realm.Configuration.defaultConfiguration = config
		self.quotes = fetchQuotes()
	}

	func addQuote(_ quote: Quote) {
		let realm = try! Realm(configuration: config)

		try! realm.write {
			realm.add(quote)
		}
		quotes = fetchQuotes()
	}

	func fetchQuotes() -> [Quote] {
		let realm = try! Realm(configuration: config)

		let results = realm.objects(Quote.self).sorted(byKeyPath: "date", ascending: false)
		return results.map { $0 }
	}

	func loadCategories() -> [String] {
		quotes = fetchQuotes()
		let allCategories = quotes.flatMap { $0.categories }
		let uniqueCategories = Set(allCategories)
		return Array(uniqueCategories).sorted()
	}

	private func getEncryptionKey() -> Data {
		let keychain = KeychainSwift()
		let realmKeychainKey = "realmKeychainKey"

		if let storedKeyData = keychain.getData(realmKeychainKey) {
			return storedKeyData
		}

		var key = Data(count: 64)
		_ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
			SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
		}

		keychain.set(key, forKey: realmKeychainKey)
		return key
	}
}
