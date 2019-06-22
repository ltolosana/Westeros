//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 13/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

final class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var houseNameLabel: UILabel!
    @IBOutlet private weak var sigilImageView: UIImageView!
    @IBOutlet private weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    private var model: House
    
    
    // MARK: - Initialization
    init(model: House) {
        // Primero tenemos que limpiar nuestra propia mierda
        self.model = model
        // Despues podemos llamar a supoer.init
        // super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    // El required init de debajo hay que dejarlo por narices, por culpa de apple
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
    
}

extension HouseDetailViewController {
    private func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        
    }
}

extension HouseDetailViewController {
    private func setupUI() {
        // Creo mi boton
        let wikiButton = UIBarButtonItem(
            title: "Wiki",
            style: .plain, // Podemos poner la forma larga UIBarButtonItem.Style.plain pero como Swift puede inferir el tupo con poner .plain ya es suficiente
            target: self, // El target es donde esta definido el metodo del 'action'
            action: #selector(displayWiki)
        )
        
        let membersButton = UIBarButtonItem(
            title: "Members",
            style: .plain,
            target: self,
            action: #selector(displayMembers)
        )
        
        // Lo añado a la navigation bar
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
        
    }
    
    @objc private func displayWiki() {
        // Crear el wikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Mostrarlo mediante un push navigation controller
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc private func displayMembers() {
        // TODO: Hacer para el jueves
        // LMT - Creo el membersVC
        // Xandre lo ha hecho igual que yo
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        
        // LMT - Lo muestro mediante un push
        navigationController?.pushViewController(memberListViewController, animated: true)
        
    }
}

// MARK: - House List View Controller Delegate
extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House) {
        
        model = house
        syncModelWithView()
    }
}

