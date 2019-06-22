//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 18/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

// let HOUSE_KEY: String = "HouseKey"
// let HOUSE_DID_CHANGE_NOTIFICATION_NAME: String = "HouseDidChangeNotificationName"
// let LAST_HOUSE_KEY = "LastHouseKey"

protocol HouseListViewControllerDelegate: class { // Lo del : class es por lo de weak del delegado  de mas abajo
    
    // should
    // will
    // did
    
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House)
}

class HouseListViewController: UITableViewController {
    
    enum Constants {
        static let houseKey: String = "HouseKey"
        static let lastHouseKey = "LastHouseKey"
    }
    
    // MARK: Properties
    private let model: [House]
    weak var delegate: HouseListViewControllerDelegate? // Los delegados tiene que ser siempre weak y tenemos que poner en la definicion lo de : class
    
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
        
//        // Crear el VC de la casa
//        let houseDetailViewController = HouseDetailViewController(model: house)
//
//        // Mostrarlo
//        navigationController?.pushViewController(houseDetailViewController, animated: true)
        
        // Cambiamos lo anterior y usamos el protocolo de delegado
        // Avisar al delegado
        // Enviamos la informacion de que se ha seleccionado una casa
        delegate?.houseListViewController(self, didSelectHouse: house)

        // Mandamos la misma informacion a traves de las notifications
        let notificationCenter = NotificationCenter.default
        
        let dictionary = [Constants.houseKey: house]
        
        let notification = Notification(
            name: .houseDidNotificationName,
            object: self,
            userInfo: dictionary
        )
        
        notificationCenter.post(notification)
        
        // Guardar la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        
    }
}

extension HouseListViewController {
    
    private func saveLastSelectedHouse(at index: Int) {
        // Escribimos en UserDefaults
        let userDefaults = UserDefaults.standard // Es un singleton
        userDefaults.set(index, forKey: Constants.lastHouseKey)
        userDefaults.synchronize() // Desde hace unas versiones de iOS ya no es necesario pero lo hacemos por si acaso
    }
    
    func lastSelectedHouse() -> House {
        // Leer de User Defaults
        let userDefaults = UserDefaults.standard
        let lastIndex = userDefaults.integer(forKey: Constants.lastHouseKey) // El metodo "integer" de UserDefaults, si no existe la clave, devuelve 0
        
        // Devolvemos la casa
        return model[lastIndex]
    }
}
