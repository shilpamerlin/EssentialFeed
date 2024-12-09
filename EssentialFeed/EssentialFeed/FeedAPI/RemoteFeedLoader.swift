//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Shilpa Joy on 2024-12-09.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}


public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    public func load() {
        client.get(from: url)
    }
}
