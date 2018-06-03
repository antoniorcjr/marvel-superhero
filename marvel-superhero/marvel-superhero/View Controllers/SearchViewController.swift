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
    var loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    @IBOutlet weak var tableView: UITableView!

    // MARK: - View model object
    var viewModel: SearchViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - View life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        fetchSuperHeroesData()
    }

    private func setupView() {
        loading.hidesWhenStopped = true
        loading.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loading.startAnimating()

        tableView.backgroundView = loading
    }

    private func updateView() {
        DispatchQueue.main.async {
            if let _ = self.tableView {
                self.tableView.reloadData()
                self.loading.stopAnimating()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fetchSuperHeroesData() {
        let dataManager = DataManager()
        dataManager.superHeroData(limit: 20, offset: 0, query: "") { (superHero) in
            self.viewModel = SearchViewModel(superHeroes: superHero)
        }
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
