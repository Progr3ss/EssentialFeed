//
//  RemoteFeedLoader.swift
//  EssentailFeed
//
//  Created by martin chibwe on 7/15/21.
//

import Foundation

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
            
            case let  .success(data, response ):
                do {
                    let items =  try
                        FeedItemsMapper.map(data,response)
                    completion(.success(items))
                } catch {
                    completion(.failure(.invalidData))
                }
                
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
