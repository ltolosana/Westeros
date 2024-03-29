//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 29/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
    
    // MARK: - Properties
    private var model: [Episode]
    
//    private var table: UITableView?
    
    // MARK: - Initialization
    init (model: [Episode], seasonName: String) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
//        title = "Mostrar aqui la temporada que corresponde"
        title = seasonName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
//    extension SeasonListViewController {
//        private func syncModelWithView() {
//        
//        }
//    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        // Miramos el episodio que hay que mostrar
        let episode = model[indexPath.row]
        
        // Creamos la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizamos modelo (episode) y vist (celda)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        cell?.textLabel?.text = episode.title
        cell?.detailTextLabel?.text = "Fecha de Emisión: \(dateFormatter.string(from: episode.firstAired))"

        // Devolvemos la celda

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguamos que Episodio se ha pussado
        let episode = model[indexPath.row]
        
        // Creamos el VC del detalle de Episodio
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        // Y lo mostramos
        navigationController?.pushViewController(episodeDetailViewController, animated: true)

    }
    
}


// MARK: - Season List View Controller Delegate
extension EpisodeListViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        // Sincronizo vista y modelo
        // En este caso actualizo el modelo con los episodios de la nueva temporada seleccionada y actualizo tambien el titulo con el nombre de la temporada
        model = season.sortedEpisodes
        title = season.name
//        syncModelWithView()
        // Recargo la tabla para que actualice los datos del modelo
        tableView.reloadData()
    }
}
