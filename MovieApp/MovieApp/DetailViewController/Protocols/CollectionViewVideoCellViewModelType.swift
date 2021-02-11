//
//  CollectionViewVideoCellViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol CollectionViewVideoCellViewModelType: class {
    
    var id: String? { get }
    var key: String? { get }
    var name: String? { get }
    var type: String? { get }
    var size: Int? { get }
    var site: String? { get }
}
