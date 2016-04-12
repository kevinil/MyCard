//
//  Constants.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import Foundation
import UIKit


var screenWidth : CGFloat { get { return UIScreen.mainScreen().bounds.width } }
var screenHeight : CGFloat { get { return UIScreen.mainScreen().bounds.height } }

public func addAlertAction(alert: UIAlertController, title: String, handler: ((UIAlertAction!) -> Void)!) {
    alert.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.Default, handler: handler))
}

public func addCancelAlertAction(alert: UIAlertController, title: String, handler: ((UIAlertAction!) -> Void)!) {
    alert.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.Cancel, handler: handler))
}
