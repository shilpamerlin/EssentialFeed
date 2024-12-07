//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shilpa Joy on 2024-12-07.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient() //single point of access
    func get(from url: URL) {}

}

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    override func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        
        let sut = RemoteFeedLoader()
        sut.load()
        
        //when invoke load RemoteFeedLoader invoke a method in client
        XCTAssertNotNil(client.requestedURL)
    }

}
