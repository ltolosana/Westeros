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
//        syncModelWithView()
//        subscribeToNotifications()
//    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        setupUI()
        syncModelWithView()
        subscribeToNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotifications()
    }

}

extension EpisodeDetailViewController {
    private func subscribeToNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(seasonDidChange),
            name: .seasonDidNotificationName,
            object: nil
        )
    }
    
    private func unsubscribeNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func seasonDidChange(notification: Notification) {
        // Averiguo la temporada
        guard let dictionary = notification.userInfo else { return }
        guard let season = dictionary[SeasonListViewController.Constants.seasonKey] as? Season else { return }
        
        // Cambio de temporada (actualizo el modelo)
        model = season.sortedEpisodes[0]
        
        // Sincronizo y salgo de la vista de detalle
        syncModelWithView()
        navigationController?.popViewController(animated: true)
        
    }
}


extension EpisodeDetailViewController {
    private func syncModelWithView() {
        title = model.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        episodeTitleLabel.text = "Capitulo: \(model.title)"
        if let season = model.season {
            episodeSeasonLabel.text = "Correspondiente a la \(season.name)"
        } else {
            episodeSeasonLabel.text = "Debo mirar a ver por que esto no va"
        }
        firstAiredLabel.text = "Fecha Emisión: \(dateFormatter.string(from: model.firstAired))"
        
    }
}
