//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 19/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var model: [Person]
    private var houseNameOfModel: String
    
    // MARK: - Initialization
    init(model: [Person], houseNamed: String) {
        self.model = model
        self.houseNameOfModel = houseNamed
        
        super.init(nibName: nil, bundle: nil)
        title = "Members of House \(houseNameOfModel)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // LMT - Hecho por mi
        // Xandre: OJO. No olvidarse de asignar el dataSource
        tableView.dataSource = self
//        tableView.delegate = self
        
        subscribeToNotifications()

    }

    // LMT - Hecho por mi
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotifications()
    }
}

// TODO: Implementar/conformarse a los protocolos de delegate y datasource
// el TableView necesita un delegado
// UITAbleViewDelegate y UITAbleViewDataSource
// el controlador es que sera el delegado

// LMT - Hecho por mi
//extension MemberListViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cellId = "memberCell"
//
//        // Descubrir cual es la la persona que tenemos que mostrar
//        let person = model[indexPath.row]
//
//        // Crear una celda
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
//
//        // Sincronizar modelo(house) - vista(celda)
//        cell.textLabel?.text = person.name
//        cell.detailTextLabel?.text = person.alias
//        cell.imageView?.image = person.house.sigil.image
//
//        // Devolver la celda
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//
//}

// Lo que ha hecho Xandre

// MARK: - Table View data source
extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonCell"
        
        // Descubrir que persona tengo que mostrar
        let person = model[indexPath.row]
        
        // Crear la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        // Sincronizar model-view
        cell.textLabel?.text = person.fullName
        cell.detailTextLabel?.text = person.alias
        
        
        // Devolver la celda
        return cell
        
    }

}

extension MemberListViewController {
    private func subscribeToNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(houseDidChange),
            name: .houseDidNotificationName,
            object: nil
        )
    }
    
    private func unsubscribeNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func houseDidChange(notification: Notification) {
        guard let dictionary = notification.userInfo else { return }
        guard let house = dictionary[HouseListViewController.Constants.houseKey] as? House else { return }
        model = house.sortedMembers
        houseNameOfModel = house.name
        syncModelWithView()
    }
}

extension MemberListViewController {
    private func syncModelWithView() {
        title = "Members of House \(houseNameOfModel)"
        
//        self.navigationItem.backBarButtonItem?.title = houseNameOfModel   // Esto no funciona porque hay que crear un backbutton propio
        tableView.reloadData()
    }
}
