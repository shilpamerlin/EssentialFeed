//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
	case success([FeedItem])
	case failure(Error)
}

protocol FeedLoader: RemoteFeedLoader {
    
    associatedtype Error: Swift.Error
	func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
