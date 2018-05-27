//
//  CacheManager.swift
//  Cache
//
//  Created by 曹冲 on 2018/5/27.
//

import UIKit
import Cache

public class CacheManagerSwift {
    private static let sharedManager: CacheManagerSwift = {
        let cacheManager = CacheManagerSwift.init()
        return cacheManager
    }()
    
    var storage: Storage?
    
    init() {}
    
    public convenience init(diskConfig:DiskConfig ,memoryConfig: MemoryConfig) {
        self.init()
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        } catch  {
            print("CacheManager: -- \(error.localizedDescription)")
        }
    }
    
    
    /**异步存储*/
    public func setObjcetAsync<T: Codable>(object: T, forKey key: String, completion: @escaping (Bool) -> Void) {
        storage?.async.setObject(object, forKey: cacheKey(keyStr: key), completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value:
                    completion(true)
                case .error:
                    completion(false)
                }
            }
            
        })
    }
    
    /**直接存储*/
    public func setObject<T: Codable>(object: T, forKey key: String) -> Bool {
        do {
            try storage?.setObject(object, forKey: cacheKey(keyStr: key))
            return true
        } catch  {
            return false
        }
    }
    
    /**读取缓存*/
    public func object<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
        do {
            return try storage?.object(ofType: type, forKey: cacheKey(keyStr: key))
        } catch  {
            return nil
        }
    }
    
    /**异步读取缓存*/
    public func objectAsync<T: Codable>(ofType type: T.Type, forKey key: String, completion: @escaping(Cache.Result<T>) -> Void) {
        storage?.async.object(ofType: type, forKey: cacheKey(keyStr: key), completion: completion)
    }
    
    /**根据key值清除缓存*/
    public func removeCacheObject(forKey key: String, completion: @escaping (Bool) -> Void) {
        storage?.async.removeObject(forKey: cacheKey(keyStr: key), completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value:
                    completion(true)
                case .error:
                    completion(false)
                }
            }
        })
    }
    
    /**清除所有缓存*/
    public func removeAllObject(completion: @escaping (Bool) -> Void) {
        storage?.async.removeAll(completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value:
                    completion(true)
                case .error:
                    completion(false)
                }
            }
        })
    }
    
    /**缓存中是否存在*/
    public func isExistObject<T: Codable>(ofType type: T.Type ,forKey key: String , completion: @escaping(Bool) -> Void) {
        storage?.async.existsObject(ofType: type, forKey: cacheKey(keyStr: key), completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .value:
                    completion(true)
                case .error:
                    completion(false)
                }
            }
        })
    }
    
    /**清除所有过期的缓存*/
     public func clearExpiredObjects(completion: @escaping(Bool) -> Void ) {
        storage?.async.removeExpiredObjects(completion: { (result) in
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    switch result {
                    case .value:
                        completion(true)
                    case .error:
                        completion(false)
                    }
                }
            }
        })
    }
    
    private func cacheKey(keyStr: String) -> String {
        return MD5(keyStr)
    }
}
