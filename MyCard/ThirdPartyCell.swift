//
//  ThirdPartyCell.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/29.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

var thirds : [String] = ["card_wechat","card_weibo","card_maimai","card_in","card_facebook","card_add"]
var thirdTaps : [UITapGestureRecognizer] = []

protocol ThirdPartyDelegate {
    func perfromSegueToThirdVC()
}

class ThirdPartyCell: UITableViewCell {
    
    var sv : UIScrollView!
    var delegate : ThirdPartyDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        backgroundColor = .clearColor()
        
        createMenu()
    }
    
    func createMenu() {
        sv = UIScrollView(frame: CGRectMake(0, 0, contentView.bounds.width + 8, 80))
        sv.contentSize = CGSizeMake(max((CGFloat(thirds.count) * 65 + 60), contentView.bounds.width + 8), 80)
        sv.showsHorizontalScrollIndicator = false
        contentView.addSubview(sv)
        createItems()
    }
    
    func createItems() {
        for index in 0..<thirds.count {
            let iv = UIImageView(image: UIImage(named: thirds[index]))
            let tap = createTap(thirds[index])
            iv.addGestureRecognizer(tap)
            iv.frame = CGRectMake(15 + CGFloat(index) * 65, 15, 50, 50)
            iv.layer.cornerRadius = 10
            iv.layer.masksToBounds = true
            iv.userInteractionEnabled = true
            sv.addSubview(iv)
        }
        
    }
    
    func createTap(fileName: String) -> UITapGestureRecognizer {
        switch fileName {
        case "card_wechat":
            return UITapGestureRecognizer(target: self, action: #selector(ThirdPartyCell.goWechat))
        case "card_weibo":
            return UITapGestureRecognizer(target: self, action: #selector(ThirdPartyCell.goWeibo))
        case "card_in":
            return UITapGestureRecognizer(target: self, action: #selector(ThirdPartyCell.goIn))
        case "card_maimai":
            return UITapGestureRecognizer(target: self, action: #selector(ThirdPartyCell.goMaimai))
        case "card_facebook":
            return UITapGestureRecognizer(target: self, action: #selector(ThirdPartyCell.goFacebook))
        default :
            return UITapGestureRecognizer(target: self, action: #selector(ThirdPartyCell.addMore))
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //gothird
    
    func goWechat() {
        print("wechat")
    }
    
    func goWeibo() {
        print("weibo")
    }
    
    func goFacebook() {
        print("facebook")
    }
    
    func goIn() {
        print("instagram")
    }
    
    func goMaimai() {
        print("maimai")
    }
    
    func addMore() {
        print("add")
        delegate?.perfromSegueToThirdVC()
    }

}
