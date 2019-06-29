//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 29/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class SeasonListViewController: UITableViewController {
    
    // MARK: Properties
    private let model: [Season]
    
    
    // MARK: Initialization
    init (model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Miramos a ver la season que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Creamos una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // SIncronizamos modelo (season) y vista (celda)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell?.textLabel?.text = season.name
        cell?.detailTextLabel?.text = "Fecha Emisión: \(dateFormatter.string(from: season.firstAired))"
        
        // Devolvemos la celda
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que Temporada se ha pulsado
        let season = model[indexPath.row]
        
        // Crear el VC de la Temporada
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        
        // Y lo mostramosMostrarlo
        navigationController?.pushViewController(seasonDetailViewController, animated: true)

    }
    
}
