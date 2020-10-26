//
//  MyError.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 10/22/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation

enum MyError : String, Error {
    case invalidURL         = "Invalid URL. Please double check."
    case unableToComplete   = "Unable to complete your request. Please check Internet connection."
    case invalidResponse    = "Invalid response from server. Please Try again."
    case invalidData        = "Invalid data received from the server. Please Try again."
    case unableToSave       = "There was an error favoriting this user!"
    case emptyCoreData      = "CoreData is Empty"
}
