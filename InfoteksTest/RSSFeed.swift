//
//  RSSFeed.swift
//  InfoteksTest
//
//  Created by NIKOLAY FOKIN on 27.12.16.
//  Copyright © 2016 Fonixsoft LLC. All rights reserved.
//

import Foundation
import SWXMLHash

struct RSSFeed: XMLIndexerDeserializable {
    static func deserialize(_ element: XMLIndexer) throws -> RSSFeed {
        var channels: [RSSChannel] = []
        if let rssElement = element.children.first {
            for channelEl in rssElement.children {
                do {
                    let channel: RSSChannel = try channelEl.value()
                    channels.append(channel)
                } catch {
                    print(error)
                }
            }
        }
        
        var items: [RSSChannelItem] = []
        for channel in channels {
            for item in channel.items {
                items.append(item)
            }
        }
        
        return RSSFeed(
            channels : channels,
            items    : items
        )
    }
    
    var channels : [RSSChannel]     = []
    var items    : [RSSChannelItem] = []
}
