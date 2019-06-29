//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 29/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var firstAiredLabel: UILabel!
    
    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Properties
    private var model: Season

    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.name
        
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

extension SeasonDetailViewController {
    private func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
            
        seasonNameLabel.text = "Temporada: \(model.name)"
        firstAiredLabel.text = "Fecha Emisión: \(dateFormatter.string(from: model.firstAired))"
    }
}



