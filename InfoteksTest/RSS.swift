//
//  RSS.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 28.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import Foundation
import SWXMLHash

class RSS {
    init() {
        var cacheUrl: URL?
        if let cacheUrlString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsUrl = URL(string: cacheUrlString)
            cacheUrl = documentsUrl?.appendingPathComponent("cache.xml")
        }
        
        self.cacheUrl = cacheUrl
    }
    
    func updateAsync() {
        DispatchQueue.global(qos: .background).async {
            self.update()
        }
    }
    
    func update() {
        do {
            let data = try Data(contentsOf: self.url)
            self.updated = true
            self.loadData(data: data)
            
            self.saveCache(data: data)
        } catch {
            print("Data loading error")
            print("\(error)")
        }
    }
    
    func saveCache(data: Data) {
        if let cacheUrl = self.cacheUrl {
            do {
                try data.write(to: cacheUrl)
            } catch {
                print("Cache Save Error")
            }
        }
    }
    
    func loadCache() {
        if let cacheUrl = self.cacheUrl {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: cacheUrl.absoluteString) {
                do {
                    let data = try Data(contentsOf: cacheUrl)
                    loadData(data: data)
                } catch {
                    print("Cache Load Error")
                    print(error)
                }
            }
        }
    }
    
    func loadData(data: Data){
        let index = SWXMLHash.parse(data)
        
        do {
            let feed:RSSFeed = try index.value()
            self.feed   = feed
            self.loaded = true
            
            if let delegate = self.delegate {
                delegate.rssLoaded()
            }
        } catch {
            print("Deserialization exception")
        }
    }
    
    func start() {
        loadCache()
        updateAsync()
    }
    
    var updated  : Bool = false
    var loaded   : Bool = false
    
    var feed     : RSSFeed?
    
    var delegate : RSSDelegate?
    
    let cacheUrl : URL?
    let url      : URL = URL(string: "https://4pda.ru/feed/")!
}

protocol RSSDelegate {
    func rssLoaded()
}
