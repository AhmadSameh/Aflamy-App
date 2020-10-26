//
//  CoreDataManager.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 10/22/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    // MARK: - CoreData Logic


    var movies : [NSManagedObject] = [NSManagedObject]()
    
    func saveInCoreData(film : Film){
        
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appdelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
    let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
        
      
            movie.setValue(film.genre, forKey: "movieGenre")
            movie.setValue(film.title, forKey: "movieTitle")
            movie.setValue(film.image, forKey: "movieImageName")
            movie.setValue(film.rating, forKey: "movieRating")
            movie.setValue(film.releaseYear, forKey: "movieReleaseYear")

            do{
                try managedContext.save()
                
            }catch let error as NSError{
                assertionFailure("Error saving in CoreData \(String(describing: error.localizedRecoverySuggestion))")
            }

            
        
    }
    
    
    
    
    
    
    func fetchDataFromCoreData(completed : @escaping (Swift.Result<[NSManagedObject] , MyError>) -> Void){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let managedContext = appdelegate.persistentContainer.viewContext
        
        
        
        do{
            
            movies = try managedContext.fetch(fetchRequest)
            
            if movies.isEmpty{
                print("empty coredata")
                completed(.failure(.emptyCoreData))
            }

            completed(.success(movies))
            
        }catch let error as NSError{
            
            print(error)
        }
    }
    
    
    
    func DeleteAllData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Movie"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
}
