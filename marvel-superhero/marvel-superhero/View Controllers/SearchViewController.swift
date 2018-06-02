//
//  SearchViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 02/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View model object
    var viewModel: SearchViewModel? = SearchViewModel()

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
        guard let viewModel = viewModel else { return 0 }
        return viewModel.sections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuperHeroTableViewCell.cellReuseIdentifier, for: indexPath) as? SuperHeroTableViewCell else { fatalError("Unexpected Table View Cell") }
        if let viewModel = viewModel?.viewModel(for: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }

        return cell
    }
}
