//
//  Hero.swift
//  1tsApp
//
//  Created by mac on 11/1/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct Hero {
    var id: Int = 0
    var name: String = ""
    var defaulUrl = "https://api.opendota.com"
    var url: URL?
    
    func getUrl(from StringUrl: String) -> URL? {
        let url = URL(string: StringUrl)
        return url
    }
    
    init?(JsonData: [String : Any]) {
        guard let id = JsonData["id"] as? Int,
            let name: String = JsonData["localized_name"] as? String,
        let img: String = JsonData["img"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.url = getUrl(from: defaulUrl + img)
    }
}
