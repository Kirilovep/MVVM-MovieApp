//
//  CollectionViewCrewCellViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class CollectionViewCrewCellViewModel: CollectionViewCrewCellViewModelType {
    
    private var crew: Crew
    
    
    var creditId: String? {
        return crew.creditId
    }
    
    var department: String? {
        return crew.department
    }
    
    var gender: Int? {
        return crew.gender
    }
    
    var id: Int? {
        return crew.id
    }
    
    var job: String? {
        return crew.job
    }
    
    var name: String? {
        return crew.name
    }
    
    var profilePath: String? {
        return crew.profilePath
    }
    
    init(crew: Crew) {
        self.crew = crew
    }
    
    
    
    
}
