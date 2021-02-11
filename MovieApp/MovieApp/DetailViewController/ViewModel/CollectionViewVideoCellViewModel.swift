//
//  CollectionViewVideoCellViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class CollectionViewVideoCellViewModel: CollectionViewVideoCellViewModelType {
    
    private var videos: Video
    
    var id: String? {
        return videos.id
    }
    
    var key: String? {
        return videos.key
    }
    
    var name: String? {
        return videos.name
    }
    
    var type: String? {
        return videos.type
    }
    
    var size: Int? {
        return videos.size
    }
    
    var site: String? {
        return videos.site
    }
    
    init(videos: Video) {
        self.videos = videos
    }
    
    
}
