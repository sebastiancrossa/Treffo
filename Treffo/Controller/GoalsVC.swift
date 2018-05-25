//
//  GoalsVC.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/9/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

