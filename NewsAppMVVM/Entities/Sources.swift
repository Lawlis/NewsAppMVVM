//
//  Sources.swift
//  NewsAppMVVM
//
//  Created by Laurynas Letkauskas on 17/11/2019.
//  Copyright © 2019 Laurynas Letkauskas. All rights reserved.
//

import SwiftyJSON

class Sources: Identifiable {
    var sourceID: String = ""
    var sourceName: String = ""
    var sourceDescription: String = ""
    var sourceURL: String = ""
    var sourceCategory: String = ""
    var sourceLanguage: String = ""
    var sourceCountry: String = ""
    
    init(sourcesJSON: JSON) {
        sourceID = sourcesJSON["id"].string!
        sourceName = sourcesJSON["name"].string!
        sourceDescription = sourcesJSON["description"].string!
        sourceURL = sourcesJSON["url"].string!
        sourceCategory = sourcesJSON["category"].string!
        sourceLanguage = sourcesJSON["language"].string!
        sourceCountry = sourcesJSON["country"].string!
    }
}
