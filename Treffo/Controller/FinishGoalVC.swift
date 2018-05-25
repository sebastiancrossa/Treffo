//
//  FinishGoalVC.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/24/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit
import CoreData

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
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        // Setting up the model
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return } // If we cannot retrieve this we can't move forward
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDesciption
        goal.goalType = goalType.rawValue // The raw value of the raw type is a String
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        // Saving into persistent storage
        do {
           try managedContext.save()
            print("Saved data")
            completion(true)
        } catch {
            debugPrint("TREFFO | Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
