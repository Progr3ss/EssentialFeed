//
//  HTTPClient.swift
//  EssentailFeed
//
//  Created by martin chibwe on 7/22/21.
//

import Foundation

public enum HTTPClientResult {
    case success(Data,HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL,completion:@escaping (HTTPClientResult) -> Void)
}
