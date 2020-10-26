//
//  Movie.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 10/22/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation

struct Film : Codable , Error{
    
    var title       : String
    var image       : String
    var rating      : Double
    var releaseYear : Int
    var genre       : [String]
    
    
}
