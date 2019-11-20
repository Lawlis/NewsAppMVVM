//
//  ContentView.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = SourcesListViewModel()
    
    var body: some View {
        NavigationView {
            List(model.sources) { source in
                
                VStack(alignment: .center) {
                    Text(source.name)

                        

                    Text(source.description)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                .navigationBarTitle(Text("Sources"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
