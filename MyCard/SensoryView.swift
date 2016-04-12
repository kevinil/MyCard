//
//  SensoryView.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/31.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import SnapKit

class SensoryView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    static let sharedInstance = SensoryView()
    
    var dataArray = ["13983899779","303418755@qq.com","重庆大本营","233333"]
    var images = ["card_phone","card_email","card_loc","card_live"]
    
    var bgMaskView : UIView!
    var bgBlurView : UIVisualEffectView!
    var topCoverIV : UIImageView!
    var closeButton : UIButton!
    var nameView : UIView!
    var nameLabel : UILabel!
    var qrcodeImageView : UIImageView!
    var sensorTVC : UITableView!
    var saveButton : UIButton!
    var shareButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bgMaskView = UIView(frame: self.bounds)
        bgMaskView.backgroundColor = UIColor.blackColor()
        bgMaskView.alpha = 0.7
        addSubview(bgMaskView)
        
        bgBlurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        bgBlurView.frame = CGRectMake(50, 70, bounds.width - 100, bounds.height - 150)
        bgBlurView.layer.cornerRadius = 10
        bgBlurView.layer.masksToBounds = true
        addSubview(bgBlurView)
        
        topCoverIV = UIImageView(frame: CGRectMake(50, 70, bounds.width - 100, 200))
        maskCorner(topCoverIV, corners: [.TopLeft, .TopRight])
        topCoverIV.image = UIImage(named: "bg")
        addSubview(topCoverIV)
        
        closeButton = UIButton(frame: CGRectMake(bounds.width - 80, 80 , 20, 20))
        closeButton.setImage(UIImage(named: "close"), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: #selector(SensoryView.removeSelf), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(closeButton)
        
        nameView = UIView(frame: CGRectMake(50, 230, bounds.width - 100, 40))
        nameView.backgroundColor = UIColor.blackColor()
        nameView.alpha = 0.3
        addSubview(nameView)
        
        nameLabel = UILabel(frame: CGRectMake(60, 230, bounds.width - 175, 40))
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.systemFontOfSize(20)
        nameLabel.text = "Kevinil, iOS"
        addSubview(nameLabel)
        
        qrcodeImageView = UIImageView(frame: CGRectMake(bounds.width - 85, 238, 25, 25))
        qrcodeImageView.image = UIImage(named: "card_qrcode")
        addSubview(qrcodeImageView)
        
        sensorTVC = UITableView(frame: CGRectMake(50, 270, bounds.width - 100, bounds.height - 400))
        sensorTVC.delegate = self
        sensorTVC.dataSource = self
        sensorTVC.registerClass(SensorCell.self, forCellReuseIdentifier: "sensorCell")
        sensorTVC.registerClass(ThirdPartyCell.self, forCellReuseIdentifier: "thirdPartyCell")
        sensorTVC.backgroundColor = UIColor.clearColor()
        sensorTVC.showsVerticalScrollIndicator = false
        addSubview(sensorTVC)
        
        saveButton = UIButton(frame: CGRectMake(50, bounds.height - 130, (bounds.width - 100) / 2, 50))
        saveButton.setTitle("保存到通讯录", forState: UIControlState.Normal)
        saveButton.backgroundColor = UIColor(red: 21/255, green: 128/255, blue: 168/255, alpha: 1)
        maskCorner(saveButton, corners: UIRectCorner.BottomLeft)
        addSubview(saveButton)
        
        shareButton = UIButton(frame: CGRectMake((bounds.width - 100) / 2 + 50, bounds.height - 130, (bounds.width - 100) / 2, 50))
        shareButton.setTitle("分享给好友", forState: UIControlState.Normal)
        shareButton.backgroundColor = UIColor(red: 63/255, green: 67/255, blue: 78/255, alpha: 1.0)
        maskCorner(shareButton, corners: UIRectCorner.BottomRight)
        addSubview(shareButton)
    }
    
    func maskCorner(item: UIView, corners: UIRectCorner) {
        let tcMaskPath = UIBezierPath(roundedRect: item.bounds, byRoundingCorners: corners, cornerRadii: CGSizeMake(10, 10))
        let tcMaskLayer = CAShapeLayer()
        tcMaskLayer.frame = item.bounds
        tcMaskLayer.path = tcMaskPath.CGPath
        item.layer.mask = tcMaskLayer
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < dataArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("sensorCell", forIndexPath: indexPath) as! SensorCell
            cell.infoIV.image = UIImage(named: images[indexPath.row])
            cell.infoLabel.text = dataArray[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("thirdPartyCell", forIndexPath: indexPath) as! ThirdPartyCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row < dataArray.count {
            return 50
        }else {
            return 80
        }
    }
    
    func removeSelf() {
        self.removeFromSuperview()
    }

}
