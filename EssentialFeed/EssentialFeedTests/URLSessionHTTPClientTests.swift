//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Shilpa Joy on 2025-01-09.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in
            
        }.resume()
    }
}
final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_createsDataTaskWithURL() {
        
        
       let url = URL(string: "https://anu-url.com")
       let session = URLSessionSpy() // setup
       let sut = URLSessionHTTPClient(session: session)
       sut.get(from: url!)
        
       XCTAssertEqual(session.receivedURLs, [url]) // expectaion
    }
    
    func test_getFromURL_resumesDataTaskWithURL() {
        
        
        let url = URL(string: "https://anu-url.com")
        let session = URLSessionSpy() // setup
        let task = URLSessionDataTaskSpy()
        session.stub(url: url!, task: task)
        let sut = URLSessionHTTPClient(session: session)
        sut.get(from: url!)
        
        XCTAssertEqual(task.resumeCallCount, 1) // expectaion
    }
    
    //MARK:- Helper Methods
    
    private class URLSessionSpy: URLSession {
        var receivedURLs = [URL]()
        private var stubs = [URL: URLSessionDataTask]()
        
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
            
            receivedURLs.append(url)
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {
            
        }
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        
        override func resume() {
            resumeCallCount += 1
        }
        
    }
}
