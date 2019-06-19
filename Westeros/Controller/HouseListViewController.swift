//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 18/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class HouseListViewController: UITableViewController {
    
    // MARK: Properties
    private let model: [House]
    
    // MARK: Initialization
    init (model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Table view data source
    // El Data Source provee de datos
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        
        // Descubrir cual es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Podemos hacer lo mismo de arriba de esta otra forma con el operador ??
        // Si hacemos esto, nos devolveria una celda NO opcional, con lo que quitariamos los ? de la cell? y el ! del cell! del return
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .default, reuseIdentifier: cellId)

        // Sincronizar modelo(house) - vista(celda)
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        // Devolver la celda
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar que casa se ha pulsado
        let house = model[indexPath.row]
        
        // Crear el VC de la casa
        let houseDetailViewController = HouseDetailViewController(model: house)
        
        // Mostrarlo
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}
