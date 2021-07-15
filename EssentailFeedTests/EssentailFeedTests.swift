//
//  EssentailFeedTests.swift
//  EssentailFeedTests
//
//  Created by martin chibwe on 7/12/21.
//

import XCTest
@testable import EssentailFeed

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
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-rul.com")!
        let (sut,client) = makeSUT(url: url)
        sut.load()
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url,url])
        XCTAssertEqual(client.requestedURL, url)
    }
    private func makeSUT(url: URL =  URL(string: "asdfasdf")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut =  RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
   private  class HTTPClientSpy: HTTPClient {
       var requestedURL: URL?
       var requestedURLs = [URL]()
    
       func get(from url: URL){
            requestedURL = url
        requestedURLs.append(url)
        }
        
    }
}
