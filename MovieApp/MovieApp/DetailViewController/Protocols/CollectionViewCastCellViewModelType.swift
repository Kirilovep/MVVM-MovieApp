//
//  CollectionViewCellViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


protocol CollectionViewCastCellViewModelType: class {
    
    var castId: Int? { get }
    var character: String? { get }
    var creditId: String? { get }
    var gender: Int? { get }
    var id: Int? { get }
    var name: String? { get }
    var order: Int? { get }
    var profilePath: String? { get }
    
    
}
