//
//  KeyboardScrollViewController.swift
//  Mooney
//
//  Created by Ricardo Gehrke Filho on 20/09/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class KeyboardScrollCoreDataEditViewController: CoreDataEditViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let keyboardSize = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! NSNumber
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.cgRectValue.height, right: 0)
        UIView.animate(withDuration: duration.doubleValue, animations: {
            self.scrollView.contentInset = inset
        })
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! NSNumber
        UIView.animate(withDuration: duration.doubleValue, animations: {
            self.scrollView.contentInset = UIEdgeInsets.zero
        }) 
    }
    
    func endEditing() {
        view.endEditing(true)
    }

}
