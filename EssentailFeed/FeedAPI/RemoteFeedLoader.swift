//
//  RemoteFeedLoader.swift
//  EssentailFeed
//
//  Created by martin chibwe on 7/15/21.
//

import Foundation
public enum HTTPClientResult {
    case success(Data,HTTPURLResponse)
    case failure(Error)
}
public protocol HTTPClient {
    func get(from url: URL,completion:@escaping (HTTPClientResult) -> Void)
}
public class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    public init(url: URL,client: HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url){ result   in
            switch result {
            case let  .success(data, _ ):
                if (try?  JSONSerialization.jsonObject(with: data)) != nil {
                    completion(.success([]))
                }else  {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
