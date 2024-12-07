//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Shilpa Joy on 2024-12-07.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}
class HTTPClient {
    static let shared = HTTPClient() //single point of access
    
    private init() {}
    
    var requestedURL: URL?
    
}
final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        
        let sut = RemoteFeedLoader()
        sut.load()
        
        //when invoke load RemoteFeedLoader invoke a method in client
        XCTAssertNotNil(client.requestedURL)
    }

}
