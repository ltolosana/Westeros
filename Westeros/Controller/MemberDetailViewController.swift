//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 30/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var memberFullNameLabel: UILabel!
    @IBOutlet weak var memberAliasLabel: UILabel!
    
    // MARK: - Properties
    private var model: Person
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
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
        syncModelWithView()
        subscribeToNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotifications()
    }
}

extension MemberDetailViewController {
    func syncModelWithView() {
        self.memberFullNameLabel.text = model.fullName
        self.memberAliasLabel.text = model.alias
    }
}

extension MemberDetailViewController {
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
//        guard let dictionary = notification.userInfo else { return }
//        guard let house = dictionary[HouseListViewController.Constants.houseKey] as? House else { return }
//        model = house.sortedMembers[0]
//         syncModelWithView()
        navigationController?.popViewController(animated: true)
    }
}
