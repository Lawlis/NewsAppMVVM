//
//  SourcesListViewModel.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import Combine

class SourcesListViewModel: ObservableObject {
    
    init() {
        fetchSources()
    }
    
    @Published var sources = [SourcesViewModel]()
    @Published var loading: Bool = true
    private func fetchSources() {
        loading = true
        NetworkManager.shared.getSourceData { (sources) in
            self.sources = sources.map(SourcesViewModel.init)
            self.loading = false
        }
    }
}
