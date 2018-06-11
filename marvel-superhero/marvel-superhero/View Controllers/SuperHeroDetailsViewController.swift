//
//  SuperHeroDetailsViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class SuperHeroDetailsViewController: UIViewController {
    // MARK: - Properties
    var comicSegue = "ComicSegue"
    var eventSegue = "EventSegue"
    var storySegue = "StorySegue"
    var serieSegue = "SerieSegue"

    @IBOutlet private var comicViewController: EventsViewController!
    @IBOutlet private var eventViewController: EventsViewController!
    @IBOutlet private var storyViewController: EventsViewController!
    @IBOutlet private var serieViewController: EventsViewController!

    @IBOutlet weak var superHeroImage: UIImageView!
    @IBOutlet weak var superHeroName: UILabel!

    var viewModel: SuperHeroViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModel = viewModel {
            superHeroImage.loadImage(fromURL: viewModel.image)
            superHeroName.text = viewModel.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case comicSegue:
            guard let destination = segue.destination as? EventsViewController else {
                fatalError("Unexpected Destination View Controller")
            }
            self.comicViewController = destination
            self.comicViewController.datas = viewModel?.superHeroData.comics
        case eventSegue:
            guard let destination = segue.destination as? EventsViewController else {
                fatalError("Unexpected Destination View Controller")
            }
            self.eventViewController = destination
            self.eventViewController.datas = viewModel?.superHeroData.events
        case storySegue:
            guard let destination = segue.destination as? EventsViewController else {
                fatalError("Unexpected Destination View Controller")
            }
            self.storyViewController = destination
            self.storyViewController.datas = viewModel?.superHeroData.stories
        case serieSegue:
            guard let destination = segue.destination as? EventsViewController else {
                fatalError("Unexpected Destination View Controller")
            }
            self.serieViewController = destination
            self.serieViewController.datas = viewModel?.superHeroData.series
        default: break
        }
    }
}
