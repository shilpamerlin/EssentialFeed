//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

public enum LoadFeedResult {
	case success([FeedItem])
	case failure(Error)
}

protocol FeedLoader: RemoteFeedLoader {

	func load(completion: @escaping (LoadFeedResult) -> Void)
}
