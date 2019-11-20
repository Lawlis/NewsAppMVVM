//
//  SourcesListViewModel.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import UIKit
import Combine

class SourcesListViewModel: ObservableObject {
    
    init() {
        fetchSources()
    }
    
    @Published var sources = [SourcesViewModel]()
    
    private func fetchSources() {
        NetworkManager.shared.getSourceData { (sources) in
            self.sources = sources.map(SourcesViewModel.init)
        }
        asdfasdfsadf
    }
}
