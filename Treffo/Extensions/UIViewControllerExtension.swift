//
//  UIViewControllerExtension.swift
//  Treffo
//
//  Created by Sebastian Crossa on 5/24/18.
//  Copyright © 2018 Sebastian Crossa. All rights reserved.
//

import UIKit

extension UIViewController {
    // Will enter from the right
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        
        transition.duration = 0.2 // Fairly good time for the desired animation
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        guard let presentedViewController = presentedViewController else { return }
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil) // At this point, the completion does not matter
        }
    }
    
    // Wiill enter from the left
    func dismissDetail() {
        let transition = CATransition()
        
        transition.duration = 0.2 // Fairly good time for the desired animation
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
}
