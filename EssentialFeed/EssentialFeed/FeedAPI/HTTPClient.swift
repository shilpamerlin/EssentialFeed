//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Shilpa Joy on 2025-01-04.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
