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
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-rul.com")!
        let (sut,client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url])
    }
    func test_load_deliverErrorOnClientError() {
        let (sut, client) = makeSUT()
        client.error = NSError(domain: "Test", code: 0)
        var capturedError = [RemoteFeedLoader.Error]()
        sut.load{ error in capturedError.append(error)}
        
        XCTAssertEqual(capturedError, [.connectivity])
    }
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-rul.com")!
        let (sut,client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url])
    }
    private func makeSUT(url: URL =  URL(string: "asdfasdf")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut =  RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    private  class HTTPClientSpy: HTTPClient {
       var requestedURLs = [URL]()
       var error: Error?
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            if let error = error {
                completion(error)
            }
            requestedURLs.append(url)
        }
    }
}
