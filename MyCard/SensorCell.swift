//
//  SensorCell.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/31.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class SensorCell: UITableViewCell {

    var infoIV : UIImageView!
    var infoLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        infoIV = UIImageView(frame: CGRectMake(15, 12, 25, 25))
        contentView.addSubview(infoIV)
        infoLabel = UILabel(frame: CGRectMake(55, 10, contentView.bounds.width - 65, 30))
        contentView.addSubview(infoLabel)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
