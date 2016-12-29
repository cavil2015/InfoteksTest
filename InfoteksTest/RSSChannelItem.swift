//
//  RSSChannelItem.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 27.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import Foundation
import SWXMLHash

struct RSSChannelItem: XMLIndexerDeserializable {
    static func deserialize(_ element: XMLIndexer) throws -> RSSChannelItem {
        return RSSChannelItem(
            title       : try element["title"].value(),
            creator     : try element["dc:creator"].value(),
            date        : try element["pubDate"].value(),
            description : try element["description"].value(),
            
            link        : try element["link"].value(),
            comments    : try element["comments"].value()
        )
    }
    
    let title       : String?
    let creator     : String?
    let date        : String?
    let description : String?
    
    let link        : String?
    let comments    : String?
}
