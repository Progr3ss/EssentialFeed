//
//  FeedItem.swift
//  EssentailFeed
//
//  Created by martin chibwe on 7/12/21.
//

import Foundation

public struct  FeedItem : Equatable{
    let id:UUID
    let description: String?
    let location: String?
    let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}

extension FeedItem: Decodable {
    private enum CodingKeys: String,CodingKey {
        case id
        case description
        case location
        case imageURL = "image"
    }
}
