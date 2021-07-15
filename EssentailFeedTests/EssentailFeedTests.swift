//
//  EssentailFeedTests.swift
//  EssentailFeedTests
//
//  Created by martin chibwe on 7/12/21.
//

import XCTest
@testable import EssentailFeed

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    init(url: URL,client: HTTPClient) {
        self.client = client
        self.url = url
    }
    func load() {
        client.get(from: url)
    }
}
protocol HTTPClient {
    func get(from url: URL)
}

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-rul.com")!
        let (sut,client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURL, url)
    }
    private func makeSUT(url: URL =  URL(string: "asdfasdf")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut =  RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
   private  class HTTPClientSpy: HTTPClient {
       var requestedURL: URL?
    
       func get(from url: URL){
            requestedURL = url
        }
        
    }
}
