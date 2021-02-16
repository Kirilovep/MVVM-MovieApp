//
//  PeopleSearchTableViewCellViewModelType.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol PeopleSearchTableViewCellViewModelType: class {
    var popularity: Double { get }
    var name: String { get }
    var id: Int { get }
    var profilePath: String { get }
    var adult: Bool { get }
    var gender: Int { get }
    var knownForDepartment: String { get }
    
}
