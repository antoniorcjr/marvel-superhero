//
//  ComicViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    // MARK: - Properties
    var loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var datas: CollectionData?

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - View model object
    var viewModel: EventsViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - View life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        let dataManager = DataManager()
        if let url = datas?.collectionUri {
            dataManager.comicData(limit: 3, collectionUri: url, completion: { (comics) in
                self.viewModel = EventsViewModel(events: comics)
                DispatchQueue.main.async {
                    if comics.count == 0 {
                        self.collectionView.isHidden = true
                    } else {
                        self.collectionView.reloadData()
                    }
                }
            })
        }
    }

    private func setupView() {
        loading.hidesWhenStopped = true
        loading.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loading.startAnimating()

        collectionView.backgroundView = loading
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentParticipationDetails" {
            if let vc = segue.destination as? ParticipationDetailsViewController {
                vc.participation = sender as? Participation
            }
        }
    }

    func updateView() {
        DispatchQueue.main.async {
            if let _ = self.collectionView {
                self.collectionView.reloadData()
                self.loading.stopAnimating()
            }
        }
    }
}

// MARK: Collection view protocols
extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.rows
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath)
                as? CustomCollectionViewCell else { return UICollectionViewCell() }

        if let viewModel = viewModel {
            cell.configure(data: viewModel.event(for: indexPath.row))
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PresentParticipationDetails", sender: viewModel?.event(for: indexPath.row))
    }
}
