//
//  ViewController.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var showTVC: UITableView!
    @IBOutlet weak var topCoverIV: UIImageView!
    @IBOutlet weak var bgBlurView: UIVisualEffectView!
    
    @IBOutlet weak var editIV: UIImageView!
    var editStyle = false
    var editTap : UITapGestureRecognizer!
    var keyboardIsShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCorner()
        editTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.toggleEdit))
        editIV.addGestureRecognizer(editTap)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func toggleEdit() {
        editStyle = !editStyle
        showTVC.reloadData()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsShown {
            keyboardIsShown = true
            if let info = notification.userInfo as? [String : AnyObject] {
                if let keyboardSize = (info["UIKeyboardFrameBeginUserInfoKey"] as? NSValue)?.CGRectValue().size{
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.showTVC.frame.origin.y -= 360 //- (self.view.frame.height - keyboardSize.height)
                        self.topCoverIV.frame.origin.y -= 360 //- (self.view.frame.height - keyboardSize.height)
                        self.bgBlurView.frame.origin.y -= 360 //- (self.view.frame.height - keyboardSize.height)
                    })
                }
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if keyboardIsShown {
            keyboardIsShown = false
            if let info = notification.userInfo as? [String : AnyObject] {
                if let keyboardSize = (info["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.CGRectValue().size{
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        self.showTVC.frame.origin.y += 360 //- (self.view.frame.height - keyboardSize.height)
                        self.topCoverIV.frame.origin.y += 360 //- (self.view.frame.height - keyboardSize.height)
                        self.bgBlurView.frame.origin.y += 360 //- (self.view.frame.height - keyboardSize.height)
                    })
                }
            }
        }
    }
    
    func createCorner() {
        bgBlurView.layer.cornerRadius = 20
        bgBlurView.layer.masksToBounds = true
        showTVC.layer.cornerRadius = 20
        showTVC.layer.masksToBounds = true
        
        
//        let tvcMaskPath = UIBezierPath(roundedRect: showTVC.bounds, byRoundingCorners: [.BottomLeft, .BottomRight], cornerRadii: CGSizeMake(20, 20))
//        let tvcMaskLayer = CAShapeLayer()
//        tvcMaskLayer.frame = showTVC.bounds
//        tvcMaskLayer.path = tvcMaskPath.CGPath
//        showTVC.layer.mask = tvcMaskLayer
        
        let tcMaskPath = UIBezierPath(roundedRect: topCoverIV.bounds, byRoundingCorners: [ UIRectCorner.TopLeft, UIRectCorner.TopRight], cornerRadii: CGSizeMake(20, 20))
        let tcMaskLayer = CAShapeLayer()
        tcMaskLayer.frame = topCoverIV.bounds
        tcMaskLayer.path = tcMaskPath.CGPath
        topCoverIV.layer.mask = tcMaskLayer
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if editStyle {
            let cell = tableView.dequeueReusableCellWithIdentifier("editCell", forIndexPath: indexPath)
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }

}
