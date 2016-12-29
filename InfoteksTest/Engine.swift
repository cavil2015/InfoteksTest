//
//  Engine.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 27.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import Foundation

class Engine {
    init() {
        rss = RSS()
    }
    
    func start() {
        rss.start()
    }
    
    let rss: RSS
    
    static let impl = Engine()
}
