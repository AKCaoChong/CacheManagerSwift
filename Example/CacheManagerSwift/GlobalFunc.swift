//
//  GlobalFunc.swift
//  CacheManager_Example
//
//  Created by 曹冲 on 2018/5/27.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import CacheManagerSwift
import Cache

let defaultCache = CacheManagerSwift.init(diskConfig: DiskConfig.init(name: "qwerdf", expiry: .never, maxSize: 0, directory: nil, protectionType: nil), memoryConfig: MemoryConfig.init(expiry: .never, countLimit: 0, totalCostLimit: 0))



