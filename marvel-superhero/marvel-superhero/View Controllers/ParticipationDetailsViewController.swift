//
//  ParticipationDetailsViewController.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 03/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit

class ParticipationDetailsViewController: UIViewController {
    // MARK: Properties
    var participation: ParticipationData?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var participationDescription: UILabel!

    // MARK: - View life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        image.loadImage(fromURL: (participation?.imagePath)!)
        name.text = participation?.title
        participationDescription.text = participation?.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
}
