//
//  CreateGoalVC.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/24/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.bindToKeyboard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        
        goalTextView.delegate = self
    }
    
    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
        goalType = .shortTerm
        
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
        goalType = .longTerm
        
        shortTermButton.setDeselectedColor()
        longTermButton.setSelectedColor()
    }
    
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        if goalTextView.text != nil && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            
            presentDetail(finishGoalVC)
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
