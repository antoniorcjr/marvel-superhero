//
//  StoryViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 10/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    // MARK: - Properties
    var datas: CollectionData?
    var stories: [Participation] = []

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - View life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataManager = DataManager()
        if let url = datas?.collectionUri {
            dataManager.comicData(limit: 3, collectionUri: url, completion: { (stories) in
                self.stories = stories
                DispatchQueue.main.async {
                    if stories.count == 0 {
                        self.collectionView.isHidden = true
                    } else {
                        self.collectionView.reloadData()
                    }
                }
            })
        }
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
}

// MARK: Collection view protocols
extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath)
                as? CustomCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(data: stories[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PresentParticipationDetails", sender: stories[indexPath.row])
    }
}
