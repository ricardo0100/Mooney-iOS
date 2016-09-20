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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: "UIKeyboardWillHideNotification", object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIKeyboardWillHideNotification", object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"]
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"]
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize?.CGRectValue().height)!, right: 0)
        UIView.animateWithDuration(duration!.doubleValue!) {
            self.scrollView.contentInset = inset
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"]
        UIView.animateWithDuration(duration!.doubleValue!) {
            self.scrollView.contentInset = UIEdgeInsetsZero
        }
    }
    
    func endEditing() {
        view.endEditing(true)
    }

}
