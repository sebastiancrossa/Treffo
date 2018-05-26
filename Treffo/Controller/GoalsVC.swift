//
//  GoalsVC.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/9/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit
import CoreData

// Accesible to other files
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goalRemoved: UIView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
        goalRemoved.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCoreDataObjects()

        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoGoalButtonWasPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.undoManager?.undo()
        fetchCoreDataObjects()
        tableView.reloadData()
        
        fadeOut(uiViewToFadeOut: goalRemoved)
        print("Button pressed")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9380082106, green: 0.1977288534, blue: 0.09307857261, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        
        let goal = goals[indexPath.row]
        
        if goal.goalProgress == goal.goalCompletionValue {
            return[deleteAction]
        } else {
            return [deleteAction, addAction]
        }
    }
}


extension GoalsVC {
    
    // Animations
    func fadeIn(uiViewToFadeIn view: UIView) {
        UIView.animate(withDuration: 3.0) {
            view.alpha = 1.0
        }
    }
    
    func fadeOut(uiViewToFadeOut view: UIView) {
        UIView.animate(withDuration: 1.0, delay: 3.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            view.alpha = 0.0
        }, completion: nil)
    }
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("TREFFO | Succesfully set goal progress")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    // Removing data from Persistant Storage
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.undoManager = UndoManager() // Will let us undo what we deleted
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("TREFFO | Succesfully removed goal")
            
            goalRemoved.alpha = 1.0
            //fadeIn(uiViewToFadeIn: goalRemoved)
            //fadeOut(uiViewToFadeOut: goalRemoved)
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    // Getting data from Persistant Storage
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("TREFFO | Succesfully fetched data")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}







