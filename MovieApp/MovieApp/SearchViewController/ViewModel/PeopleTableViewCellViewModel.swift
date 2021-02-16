//
//  PeopleTableViewCellViewModel.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class PeopleTableViewCellViewModel: PeopleSearchTableViewCellViewModelType {
    
    private var people: ResultsSearch
    
    var popularity: Double {
        return people.popularity ?? 1
    }
    
    var name: String {
        return people.name ?? ""
    }
    
    var id: Int {
        return people.id ?? 1
    }
    
    var profilePath: String {
        return people.profilePath ?? ""
    }
    
    var adult: Bool {
        return people.adult ?? true
    }
    
    var gender: Int {
        return people.gender ?? 1
    }
    
    var knownForDepartment: String {
        return people.knownForDepartment ?? ""
    }
    
    init(people: ResultsSearch) {
        self.people = people
    }
}
