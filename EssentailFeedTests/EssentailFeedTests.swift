//
//  EssentailFeedTests.swift
//  EssentailFeedTests
//
//  Created by martin chibwe on 7/12/21.
//

import XCTest
@testable import EssentailFeed

class RemoteFeedLoader {
    
}
class HTTPClient {
    var requestedURL: URL?
}
class EssentialFeedTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
       let client = HTTPClient()
        _ =  RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }
}
