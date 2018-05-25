//
//  GoalCell.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/17/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var goalProgress: UILabel!
    
    func configureCell(description: String, type: GoalType, goalProgressAmount: Int) {
        self.goalDescription.text = description
        self.goalType.text = type.rawValue // pulling out the raw value of the goal type
        self.goalProgress.text = String(describing: goalProgressAmount)
    }
    
}
