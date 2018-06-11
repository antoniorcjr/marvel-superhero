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
    var footerLoading: UIActivityIndicatorView?
    var isFooterLoadingActive: Bool = false
    var offset: Int = 0
    var limit: Int = 20
    var query: String = ""

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

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
                if self.isFooterLoadingActive {
                    self.footerLoading?.stopAnimating()
                    self.isFooterLoadingActive = false
                }
                self.tableView.reloadData()
                self.loading.stopAnimating()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fetchSuperHeroesData(withQuery: Bool = false) {
        if withQuery {
            viewModel?.superHeroes = []
            offset = 0
        }

        let dataManager = DataManager()
        dataManager.superHeroData(limit: limit, offset: offset, query: query) { (superHero) in
            if superHero.count != 0 {
                if let _ = self.viewModel {
                    self.viewModel?.superHeroes += superHero
                } else {
                    self.viewModel = SearchViewModel(superHeroes: superHero)
                }
                self.offset += self.limit
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentSuperHero" {
            let vc = segue.destination as? SuperHeroDetailsViewController
            guard let index = sender as? Int else { return }
            vc?.viewModel = viewModel?.viewModel(for: index)
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
            cell.superheroImage.image = #imageLiteral(resourceName: "marvel_notfound")
            cell.configure(viewModel: viewModel)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel?.rows {
            fetchSuperHeroesData()

            footerLoading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            footerLoading?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = footerLoading
            self.tableView.tableFooterView?.isHidden = false
            footerLoading?.startAnimating()
            isFooterLoadingActive = true
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "PresentSuperHero", sender: indexPath.row)
    }
}

// MARK: - Search Bar protocols
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            self.query = query
            fetchSuperHeroesData(withQuery: true)
            searchBar.resignFirstResponder()
            DispatchQueue.main.async {
                self.loading.startAnimating()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            clearSearch()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            clearSearch()
        }
    }

    func clearSearch() {
        searchBar.text = ""
        query = ""
        searchBar.resignFirstResponder()

        DispatchQueue.main.async {
            self.loading.startAnimating()
        }
        fetchSuperHeroesData(withQuery: true)
    }
}
