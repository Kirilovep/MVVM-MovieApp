//
//  CollectionViewCrewCellViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


protocol CollectionViewCrewCellViewModelType: class {
    
    var creditId: String? { get }
    var department: String? { get }
    var gender: Int? { get }
    var id: Int? { get }
    var job: String? { get }
    var name: String? { get }
    var profilePath: String? { get }
    
    
}
