//
//  FinishGoalVC.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/24/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDesciption: String!
    var goalType: GoalType!
    
    // initializing so we can pass on the values
    func initData(description: String, type: GoalType) {
        self.goalDesciption = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGoalButton.bindToKeyboard()
        pointsTextField.delegate = self
    }
    
    @IBAction func createGoalButtonWasPressed(_ sender: Any) {
        // Pass data into Core Data
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
