//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 29/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeSeasonLabel: UILabel!
    @IBOutlet weak var firstAiredLabel: UILabel!
   
    // MARK: - Properties
    private var model: Episode
    
    // MARK: - Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        setupUI()
        syncModelWithView()
    }
}

extension EpisodeDetailViewController {
    private func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        episodeTitleLabel.text = "Capitulo: \(model.title)"
        if let season = model.season {
            episodeSeasonLabel.text = "Correspondiente a la \(season.name))"
        } else {
            episodeSeasonLabel.text = "Debo mirar a ver por que esto no va"
        }
        firstAiredLabel.text = "Fecha Emisión: \(dateFormatter.string(from: model.firstAired))"
        
    }
}
