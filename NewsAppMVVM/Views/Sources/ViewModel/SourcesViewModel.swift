//
//  SourcesViewModel.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import UIKit

class SourcesViewModel: Identifiable {
    
    let id = UUID()
    
    let source: Sources
    
    init(source: Sources) {
        self.source = source
    }
    
    var name: String {
        return self.source.sourceName
    }
    
    var description: String {
        return self.source.sourceDescription
    }
}
