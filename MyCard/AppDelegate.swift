//
//  AppDelegate.swift
//  MyCard
//
//  Created by 刘剑文 on 16/3/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {

    var window: UIWindow?
    // BLE
    var centralManager : CBCentralManager!
    var activePerpheral : CBPeripheral!
    var peripherals  = [CBPeripheral]()
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
         (UITableView.appearance() as UITableView).tableFooterView = UIView(frame: CGRectZero)
        IQKeyboardManager.sharedManager().enable = true
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        return true
    }
    
    func justScan() {
        //clean
        if activePerpheral != nil
        {
            centralManager.cancelPeripheralConnection(activePerpheral!)
            activePerpheral = nil
        }
        peripherals.removeAll()
        
        //check & run
        print("state \(centralManager.state.rawValue)")
        if centralManager.state != CBCentralManagerState.PoweredOn
        {
            print("CoreBluetooth is not correctly initialized !\n")
        }else
        {
            centralManager.stopScan()
            centralManager.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        justScan()
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("found one blue ---- \n\(peripheral)")
        let sv = SensoryView.sharedInstance
        window?.addSubview(sv)
//        if peripheral.name == "Roboming" || peripheral.name == "RoboMing"
//        {
//            peripherals.append(peripheral)
//        }
//        //会包含一个未连接和已连接的《一机两态》
//        if peripherals.count != 0
//        {
//            for thePeripheral in peripherals
//            {
//                if thePeripheral.state != CBPeripheralState.Connected
//                {
//                    centralManager.connectPeripheral(thePeripheral, options: nil)
//                    return
//                }
//            }
//        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("manager connected to peripheral with id \(peripheral.identifier)\n")
        
        activePerpheral = peripheral
        activePerpheral?.delegate = self
        //连接成功，扫描此蓝牙能做什么服务
        activePerpheral?.discoverServices(nil)
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("manager disconnect")
        didDisconnectPeripheral()
        activePerpheral = nil
    
    }
    
    //disconnect
    func didDisconnectPeripheral() {
        
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("Fail to Connect to RoboMing")
    }
    
    func centralManager(central: CBCentralManager, willRestoreState dict: [String : AnyObject]) {
        
    }
    
    //MARK: - Perpheral Delegate
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if error == nil {
            for service in peripheral.services! {
                print("service is \(service)\n")
                print("service uuid \(service.UUID.description)\n")
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if error == nil {
            let data = (characteristic.value!)
            print("get data is \(data)")
        }else {
            print("read error")
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if error == nil {
            print("Found with \(service.UUID)\n")
            for index in 0..<service.characteristics!.count {
                let theChars = service.characteristics![index]
                peripheral.setNotifyValue(true, forCharacteristic: theChars)
                print("the char  notify is \(theChars.isNotifying) and property \(theChars.properties.rawValue)\n")
                print("Found characteristic \(theChars.UUID.description)\r\n")
            }
            centralManager.stopScan()
        }
        else {
            print("Characteristic discorvery unsuccessfull !\r\n");
        }
    }
    
    
    



}

