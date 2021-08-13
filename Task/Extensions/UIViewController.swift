//
//  UIViewController.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
import UIKit

extension UIViewController  {
  
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 
    
    
}
