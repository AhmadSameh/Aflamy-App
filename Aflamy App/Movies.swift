//
//  Movies.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 8/8/19.
//  Copyright © 2019 Ahmad Sameh. All rights reserved.
//

import UIKit
import CoreData
@objc(Movies)
class Movies: NSManagedObject {
    @NSManaged var title:String
    @NSManaged var rating:Double
    @NSManaged var releaseYear:Int
    @NSManaged var image:NSData
    @NSManaged var genre:[String]
}
