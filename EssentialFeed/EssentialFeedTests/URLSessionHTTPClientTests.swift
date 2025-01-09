//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Shilpa Joy on 2025-01-09.
//

import XCTest
import EssentialFeed

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        
        
        let url = URL(string: "https://anu-url.com")
        let session = URLSessionSpy() // setup
        let task = URLSessionDataTaskSpy()
        session.stub(url: url!, task: task)
        let sut = URLSessionHTTPClient(session: session)
        sut.get(from: url!) {_ in }
        
        XCTAssertEqual(task.resumeCallCount, 1) // expectaion
    }
    
    func test_getFromURL_failsOnRequestError() {
        let url = URL(string: "https://anu-url.com")!
        let error = NSError(domain: "any error", code: 1)
        let session = URLSessionSpy() // setup
       
        session.stub(url: url, error: error)
        let sut = URLSessionHTTPClient(session: session)
        let exp = expectation(description: "Wait for completion")
        
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError, error)
                
            default:
                XCTFail("Expected Failure with error \(error) \(result) got instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
         // expectaion
    }
    //MARK:- Helper Methods
    
    private class URLSessionSpy: URLSession {
        
        private var stubs = [URL: Stub]()
        private struct Stub {
            let task: URLSessionDataTask
            let error: Error?
        }
        func stub(url: URL, task: URLSessionDataTask = FakeURLSessionDataTask(), error: Error? = nil) {
            stubs[url] = Stub(task: task, error: error)
        }
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
          
            guard let stub = stubs[url] else {
                fatalError("Couldn't find stub for \(url)")
            }
            completionHandler(nil, nil, stub.error)
            return stub.task
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
