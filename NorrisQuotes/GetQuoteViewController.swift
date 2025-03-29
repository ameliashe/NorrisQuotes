//
//  GetQuoteViewController.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import UIKit

class GetQuoteViewController: UIViewController {

	let manager = QuotesManager()

	private lazy var label: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .medium)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var button: UIButton = {
		let button = UIButton()
		button.setTitle(title, for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .orange
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 10
		button.setTitle("Get Quote", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		label.text = manager.quotes.last?.value ?? "Press the button to get a quote!"

		addSubviews()
		setupView()
		setupButton()

	}

	func addSubviews() {
		view.addSubview(label)
		view.addSubview(button)
	}

	func setupView() {
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
			label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -25),

			button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
			button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
			button.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	func setupButton() {
		button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
	}

	@objc func handleButtonTapped() {
		let url = URL(string: "https://api.chucknorris.io/jokes/random")!

		NetworkService.request(from: url) { result in

			DispatchQueue.main.async {
				switch result {
				case .success(let data):
					if let quote = Parser.decodeQuote(data) {
						self.manager.addQuote(quote)
						self.label.text = quote.value
					} else {
						self.label.text = "Parsing error"
					}
				case .failure(let error):
					self.label.text = "Error: \(error)"
				}
			}
		}
	}
}

