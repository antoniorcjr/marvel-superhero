//
//  SearchViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Temporary Properties
    var heroes_tmp = [("SpiderMan", "Spiderman"),
                      ("Iron man", "Iron man")]

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Table view protocols
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes_tmp.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuperHeroTableViewCell.cellReuseIdentifier, for: indexPath) as? SuperHeroTableViewCell else { fatalError("Unexpected Table View Cell") }

        cell.configure(name: heroes_tmp[indexPath.row].0,
                       description: heroes_tmp[indexPath.row].1)

        return cell
    }
}
