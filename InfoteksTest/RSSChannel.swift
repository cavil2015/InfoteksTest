//
//  RSSChanel.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 27.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import Foundation
import SWXMLHash

struct RSSChannel: XMLIndexerDeserializable {
    static func deserialize(_ element: XMLIndexer) throws -> RSSChannel {
        let items: [RSSChannelItem] = try element["item"].value()
        
        return try RSSChannel(
            title: element["title"].value(),
            items: items
        )
    }
    
    var title: String
    
    var items: [RSSChannelItem] = []
}
