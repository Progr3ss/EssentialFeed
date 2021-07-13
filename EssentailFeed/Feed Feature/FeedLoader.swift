//
//  FeedLoader.swift
//  EssentailFeed
//
//  Created by martin chibwe on 7/12/21.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}
protocol FeedLoader {
    func load(completion:@escaping (LoadFeedResult) -> Void )
}
