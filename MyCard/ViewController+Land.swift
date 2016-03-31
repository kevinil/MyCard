//
//  ViewController+Land.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/31.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import Foundation
import UIKit


extension ViewController {
    
    
    
    //land card
    func showLandCard() {
        print("11")
        view.endEditing(true)
        closeCode()
        hiddenAll()
        displayLand()
    }
    
    //normal card
    func showNormalCard() {
        print("22")
        showAll()
        killLand()
    }
    
    func hiddenAll() {
        backIV.hidden = true
        cancelBtn.hidden = true
        titleLabel.hidden = true
        shareIV.hidden = true
        editIV.hidden = true
        bgBlurView.hidden = true
        topCoverIV.hidden = true
        showTVC.hidden = true
        nameView.hidden = true
        cameraIV.hidden = true
        codeIV.hidden = true
    }
    
    func showAll() {
        backIV.hidden = false
        editIV.hidden = false
        bgBlurView.hidden = false
        topCoverIV.hidden = false
        showTVC.hidden = false
        titleLabel.hidden = false
        if !editStyle {
            shareIV.hidden = false
            nameView.hidden = false
            cameraIV.hidden = false
            codeIV.hidden = false
        }else {
            backIV.hidden = true
            cancelBtn.hidden = false
        }
    }
    
    //land layout
    
    func displayLand() {
        landBgBlurView.hidden = false
        landNameLabel.hidden = false
        landDutyLabel.hidden = false
        landQRImageView.hidden = false
        landLineView.hidden = false
        landTVC.hidden = false
    }
    
    func killLand() {
        landBgBlurView.hidden = true
        landNameLabel.hidden = true
        landDutyLabel.hidden = true
        landQRImageView.hidden = true
        landLineView.hidden = true
        landTVC.hidden = true
    }

}