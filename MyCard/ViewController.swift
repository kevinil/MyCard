//
//  ViewController.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var showTVC: UITableView! { didSet { showTVC.showsVerticalScrollIndicator = false } }
    @IBOutlet weak var topCoverIV: UIImageView!
    @IBOutlet weak var bgBlurView: UIVisualEffectView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func cancelDo(sender: AnyObject) {
        view.endEditing(true)
        toggleEdit()
    }
    
    @IBOutlet weak var backIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //code blur
    
    @IBOutlet weak var codeBgView: UIView!
    @IBOutlet weak var codeShowView: UIView! {
        didSet {
            codeShowView.layer.shadowOffset  = CGSizeMake(5, 5)
            codeShowView.layer.shadowOpacity = 0.5
            codeShowView.layer.cornerRadius  = 15
        }
    }
    @IBOutlet weak var codeDetailIV: UIImageView! {
        didSet {
            codeDetailIV.layer.cornerRadius = codeDetailIV.bounds.width / 2
            codeDetailIV.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var codeDetailCloseIV: UIImageView!
    @IBOutlet weak var codeDetailQRIV: UIImageView!
    
    //orientation observer
    var otObserver : NSObjectProtocol?
    var myDevice : UIDevice!
    
    //land new UI components
//    var landBgBlurView : UIVisualEffectView!
    
    @IBOutlet weak var landBgBlurView: UIVisualEffectView! {
        didSet {
            landBgBlurView.layer.cornerRadius = 10
            landBgBlurView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var landNameLabel: UILabel!
    @IBOutlet weak var landDutyLabel: UILabel!
    @IBOutlet weak var landQRImageView: UIImageView!
    
    @IBOutlet weak var landLineView: UIView!
    @IBOutlet weak var landTVC: UITableView! {
        didSet {
            landTVC.registerClass(ThirdPartyCell.self, forCellReuseIdentifier: "thirdPartyCell")
        }
    }
    
    //bool for owner
    var ownerBool = true
    
    //ivs
    var shareIV : UIImageView!
    var editIV : UIImageView!
    var cameraIV : UIImageView!
    var codeIV : UIImageView!
    
    //edit
    
    var editStyle = false
    var editTap : UITapGestureRecognizer!
    var keyboardIsShown = false
    
    //more tap
    
    var codeTap : UITapGestureRecognizer!
    var codeCloseTap : UITapGestureRecognizer!
    var bgCloseTap : UITapGestureRecognizer!

    //data
    
    var dataArray = ["13983899779","303418755@qq.com","重庆大本营","233333"]
    var images = ["card_phone","card_email","card_loc","card_live"]
    
    //MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOrientationObserve()
        createCorner()
        setupUI()
        setupLandUI()
        
        
        showTVC.registerClass(ThirdPartyCell.self, forCellReuseIdentifier: "thirdPartyCell")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setupOrientationObserve() {
        myDevice = UIDevice.currentDevice()
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        otObserver = center.addObserverForName(UIDeviceOrientationDidChangeNotification, object: myDevice, queue: queue, usingBlock: { (notification) in
            switch self.myDevice.orientation {
            case .Portrait:
                self.showNormalCard()
            case .FaceUp :
                self.editIV.hidden ? self.showLandCard() : self.showNormalCard()
            case .FaceDown :
                self.editIV.hidden ? self.showLandCard() : self.showNormalCard()
            case .Unknown :
                self.showLandCard()
            case .PortraitUpsideDown :
                self.showNormalCard()
            case .LandscapeLeft :
                self.showLandCard()
            case .LandscapeRight :
                self.showLandCard()
        }
        })
    }
    
    func touchEnable(item: UIImageView) {
        item.userInteractionEnabled = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        updateUI()
    }
    
    
    //MARK: Setup UI
    
    func updateUI() {
        landTVC.snp_updateConstraints { (make) in
//            make.width.equalTo(view.snp_width).multipliedBy(5/9)
            make.leading.equalTo(view.snp_leading).offset(20)
            make.trailing.equalTo(view.snp_trailing).offset(-20)
            make.top.equalTo(view.snp_top).offset(20)
            make.bottom.equalTo(view.snp_bottom).offset(-20)
        }
    }
    
    func setupLandUI() {
//        landBgBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
//        view.insertSubview(landBgBlurView, belowSubview: landTVC)
//        landBgBlurView.snp_makeConstraints { (make) in
//            make.leading.equalTo(view.snp_leading).offset(20)
//            make.trailing.equalTo(view.snp_trailing).offset(-20)
//            make.top.equalTo(view.snp_top).offset(20)
//            make.bottom.equalTo(view.snp_bottom).offset(-20)
//        }
        
    
        
        
//        updateUI()
        
        print("landtvc frame \(landTVC.frame)")
        
        //        var landNameLabel : UILabel!
        //        var landDutyLabel : UILabel!
        //        var landQRImageView : UIImageView!
        //        var landTVC : UITableView!
    }
    
    func setupUI() {
        editIV = UIImageView(frame: CGRectZero)
        touchEnable(editIV)
        editIV.image = UIImage(named: "card_editBegin")
        view.insertSubview(editIV, belowSubview: codeBgView)
        shareIV = UIImageView(frame: CGRectZero)
        touchEnable(shareIV)
        shareIV.image = UIImage(named: "card_share")
        view.insertSubview(shareIV, belowSubview: codeBgView)
        cameraIV = UIImageView(frame: CGRectZero)
        touchEnable(cameraIV)
        cameraIV.image = UIImage(named: "card_Camera")
        view.insertSubview(cameraIV, belowSubview: codeBgView)
        codeIV = UIImageView(frame: CGRectZero)
        touchEnable(codeIV)
        codeIV.image = UIImage(named: "card_qrcode")
        view.insertSubview(codeIV, belowSubview: codeBgView)
        if ownerBool {
            editIV.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(25, 25))
                make.trailing.equalTo(view.snp_trailing).offset(-15)
                make.centerY.equalTo(titleLabel)
            })
            shareIV.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(25, 25))
                make.trailing.equalTo(editIV.snp_leading).offset(-15)
                make.centerY.equalTo(titleLabel)
            })
            cameraIV.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(25, 25))
                make.top.equalTo(topCoverIV.snp_top).offset(25)
                make.trailing.equalTo(topCoverIV.snp_trailing).offset(-20)
            })
            codeIV.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(25, 25))
                make.top.equalTo(cameraIV.snp_bottom).offset(15)
                make.trailing.equalTo(topCoverIV.snp_trailing).offset(-20)
            })
        }else {
            shareIV.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(25, 25))
                make.trailing.equalTo(view.snp_trailing).offset(-15)
                make.centerY.equalTo(titleLabel)
            })
            codeIV.snp_makeConstraints(closure: { (make) in
                make.size.equalTo(CGSizeMake(25, 25))
                make.top.equalTo(topCoverIV.snp_top).offset(25)
                make.trailing.equalTo(topCoverIV.snp_trailing).offset(-20)
            })
        }
        setupTaps()
    }
    
    func setupTaps() {
        editTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.toggleEdit))
        editIV.addGestureRecognizer(editTap)
        codeTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.showCode))
        codeIV.addGestureRecognizer(codeTap)
        codeCloseTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.closeCode))
        codeDetailCloseIV.addGestureRecognizer(codeCloseTap)
        bgCloseTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.closeCode))
        codeBgView.addGestureRecognizer(bgCloseTap)
    }
    
    func toggleEdit() {
        editStyle = !editStyle
        editIV.image = editStyle ? UIImage(named: "card_editDone") : UIImage(named: "card_editBegin")
        backIV.hidden = editStyle
        shareIV.hidden = editStyle
        cameraIV.hidden = editStyle
        codeIV.hidden = editStyle
        nameView.hidden = editStyle
//        nameLabel.hidden = editStyle
//        nameTF.hidden = !editStyle
//        dutyTF.hidden = !editStyle
        
        cancelBtn.hidden = !editStyle
        showTVC.reloadData()
    }
    
    func showCode() {
        codeBgView.hidden = false
        codeShowView.hidden = false
    }
    
    func closeCode() {
        codeBgView.hidden = true
        codeShowView.hidden = true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsShown {
            keyboardIsShown = true
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.showTVC.frame.size.height += 200
                self.showTVC.frame.origin.y -= 200
//                self.nameView.frame.origin.y -= 150
//                self.topCoverIV.frame.origin.y -= 150
                self.topCoverIV.hidden = true
                self.nameView.hidden = true
            })
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if keyboardIsShown {
            keyboardIsShown = false
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.showTVC.frame.size.height -= 200
                self.showTVC.frame.origin.y += 200
//                self.nameView.frame.origin.y += 150
//                self.topCoverIV.frame.origin.y += 150
                if !self.editIV.hidden {
                    self.topCoverIV.hidden = false
                    self.nameView.hidden = false
                }
            })
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
    
    //MARK : TableView Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return dataArray.count + 1
        }else {
            if ownerBool {
                return editStyle ? dataArray.count + 3 : dataArray.count + 2
            }else {
                return dataArray.count + 1
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            if indexPath.row < dataArray.count {
                let cell = tableView.dequeueReusableCellWithIdentifier("landInfoCell", forIndexPath: indexPath) as! ListCell
                cell.infoIV.image = UIImage(named: images[indexPath.row])
                cell.infoLabel.text = dataArray[indexPath.row]
                return cell
            }else {
                let cell = tableView.dequeueReusableCellWithIdentifier("thirdPartyCell", forIndexPath: indexPath) as! ThirdPartyCell
                return cell
            }
        }else {
            if ownerBool {
                if editStyle {
                    if indexPath.row == 0 {
                        let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! ListCell
                        cell.nameTF.text = "Kevinil"
                        cell.dutyTF.text = "iOS"
                        return cell
                    }else if indexPath.row < dataArray.count + 1 {
                        let cell = tableView.dequeueReusableCellWithIdentifier("editCell", forIndexPath: indexPath) as! ListCell
                        cell.editIV.image = UIImage(named: images[indexPath.row - 1])
                        cell.editTF.text = dataArray[indexPath.row - 1]
                        return cell
                    }else if indexPath.row == dataArray.count + 1 {
                        let cell = tableView.dequeueReusableCellWithIdentifier("addCell", forIndexPath: indexPath)
                        return cell
                    }else {
                        let cell = tableView.dequeueReusableCellWithIdentifier("thirdPartyCell", forIndexPath: indexPath) as! ThirdPartyCell
                        return cell
                    }
                }else {
                    if indexPath.row < dataArray.count {
                        let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! ListCell
                        cell.infoIV.image = UIImage(named: images[indexPath.row])
                        cell.infoLabel.text = dataArray[indexPath.row]
                        return cell
                    }else if indexPath.row == dataArray.count {
                        let cell = tableView.dequeueReusableCellWithIdentifier("addCell", forIndexPath: indexPath)
                        return cell
                    }else {
                        let cell = tableView.dequeueReusableCellWithIdentifier("thirdPartyCell", forIndexPath: indexPath) as! ThirdPartyCell
                        return cell
                    }
                }
            }else {
                if indexPath.row < dataArray.count {
                    let cell = tableView.dequeueReusableCellWithIdentifier("infoCell", forIndexPath: indexPath) as! ListCell
                    cell.infoIV.image = UIImage(named: images[indexPath.row])
                    cell.infoLabel.text = dataArray[indexPath.row]
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("thirdPartyCell", forIndexPath: indexPath) as! ThirdPartyCell
                    return cell
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 1 {
            if indexPath.row < dataArray.count {
                return 60
            }else {
                return 80
            }
        }else {
            if ownerBool {
                if indexPath.row < dataArray.count {
                    return 50
                }else if indexPath.row == dataArray.count {
                    return editStyle ?  50 : 44
                }else if indexPath.row == dataArray.count + 1 {
                    return editStyle ?  44 : 80
                }else {
                    return 80
                }
            }else {
                if indexPath.row < dataArray.count {
                    return 50
                }else {
                    return 80
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    
    

}
