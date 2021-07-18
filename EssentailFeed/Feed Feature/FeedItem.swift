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
}
