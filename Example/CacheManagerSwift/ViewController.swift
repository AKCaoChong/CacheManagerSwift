//
//  ViewController.swift
//  CacheManagerSwift
//
//  Created by AKCaoChong on 05/27/2018.
//  Copyright (c) 2018 AKCaoChong. All rights reserved.
//

import UIKit
import CacheManagerSwift
import Cache

class ViewController: UIViewController {
    
    var keyValue: Dictionary = [String: Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyValue["age"] = "19".data(using: .utf8)
        keyValue["name"] = "tingzi".data(using: .utf8)
        if defaultCache.setObject(object: keyValue, forKey: "people"){
            print("save success")
        }
        defaultCache.setObjcetAsync(object: keyValue, forKey: "animal") { (hello) in
            if hello{
                print("save success")
            }else{
                print("save fail")
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        /**
         defaultCache.objectAsync(ofType: [String: Data].self, forKey: "people") { (result) in
         print("peopleDic === : \(result)")
         }
         
         if let peopleDic = defaultCache.object(ofType: [String: Data].self, forKey: "people"){
         print("peopleDic: \(peopleDic)")
         if let name = String(data: peopleDic["name"]!, encoding: .utf8) {
         print("name===\(name)")
         }else{
         print("nil")
         }
         }else{
         print("peopleDic 获取失败")
         }
         */
        defaultCache.removeCacheObject(forKey: "people") { (isComplete) in
            if isComplete {
                if let peopleDic = defaultCache.object(ofType: [String: Data].self, forKey: "people"){
                    print("peopleDic: \(peopleDic)")
                    if let name = String(data: peopleDic["name"]!, encoding: .utf8) {
                        print("name===\(name)")
                    }else{
                        print("nil")
                    }
                }else{
                    print("peopleDic 获取失败")
                }
            }else{
                print("未 删 除")
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

