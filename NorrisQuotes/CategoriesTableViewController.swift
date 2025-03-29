//
//  CategoriesTableViewController.swift
//  NorrisQuotes
//
//  Created by Amelia Romanova on 3/1/25.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

	let manager = QuotesManager()
	var categories: [String] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		title = "Categories"
		navigationController?.navigationBar.prefersLargeTitles = true

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		categories = manager.loadCategories()
		tableView.reloadData()
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		var config = UIListContentConfiguration.cell()
		config.text = categories[indexPath.row]
		cell.contentConfiguration = config
		cell.accessoryType = .disclosureIndicator

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let quotesVC = QuotesTableViewController(category: categories[indexPath.row])
		navigationController?.pushViewController(quotesVC, animated: true)
	}
	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */

	/*
	 // Override to support editing the table view.
	 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	 if editingStyle == .delete {
	 // Delete the row from the data source
	 tableView.deleteRows(at: [indexPath], with: .fade)
	 } else if editingStyle == .insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */

	/*
	 // Override to support rearranging the table view.
	 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

	 }
	 */

	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
