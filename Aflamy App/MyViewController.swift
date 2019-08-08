//
//  MyViewController.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 8/7/19.
//  Copyright © 2019 Ahmad Sameh. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import CoreData
import SDWebImage

class MyViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    var movies : [NSManagedObject] = [NSManagedObject]()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .default
    
     // MARK: - Outlets
    
     @IBOutlet weak var myCollectionView: UICollectionView!
    
    // MARK: - General Variables
    
    
    
    
    // MARK: - Rechability Variables
    
    static let shared = NetworkManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    
   
    // MARK: - Parsed Array Variables
    
    var movieTitlesArray:[String] = []
    var movieReleaseDatesArray:[Int] = []
    var movieRatingsArray:[Float] = []
    var movieImagesArray:[String] = []
    var movieGenreArray : [String] = []
    
    
    
    
    

    
    // MARK: - JSON Parsing Variables
  
    
    let myUrl = URL(string: "https://api.androidhive.info/json/movies.json")
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.title = "Aflamy";
   
        
        

        // start listening
        reachabilityManager?.startListening()
        
        
        // MARK: - CoreData Logic
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        
       
        
        if NetworkReachabilityManager()!.isReachable == true {
            print("phone is connected to the internet")
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            
            let task = session.dataTask(with: myUrl!) { (data, response, error) in
                
              
                
                
                do{
//                    var myJson = try JSONSerialization .jsonObject(with: data!, options: .allowFragments) as! Array <Dictionary<String, Any>>
                    
                    
                    let myJson = try JSONSerialization .jsonObject(with: data!, options: .allowFragments)
                    
                    var JsonData = JSON(myJson)

                                        for i in 0...(JsonData.array!.count - 1){
                    
                                          
                                                var swiftJsonData = JSON(JsonData[i])
                                             let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
                                            let arr = swiftJsonData["genre"].arrayObject!
                                            let strArr : [String] = arr as! [String]
                                            movie.setValue(strArr, forKey: "movieGenre")
                                            
                                            self.movieTitlesArray.append(swiftJsonData["title"].string!)
                    
                                            movie.setValue(swiftJsonData["title"].string!, forKey: "movieTitle")
                                            
                    
                                                self.movieImagesArray.append(swiftJsonData["image"].string!)
                                            movie.setValue(swiftJsonData["image"].string!, forKey: "movieImageName")
                                                self.movieRatingsArray.append(swiftJsonData["rating"].float!)
                                            movie.setValue(swiftJsonData["rating"].float!, forKey: "movieRating")
                                            
//                                            self.movieGenreArray.append(swiftJsonData["genre"].array!)
                                            
//                                            self.movieReleaseDatesArray.append(swiftJsonData["releaseYear"].int!)
                                            
//                                            movie.setValue(swiftJsonData["releaseYear"], forKey: "movieReleaseYear")
                    
                                       self.movies.append(movie)
                                           
                                            do{
                    
                                                try managedContext.save()
                                                
                                            }catch let error as NSError{
                                                print(error)
                                            }
                                        }
                    
                    DispatchQueue.main.async {
                       self.myCollectionView.reloadData()
                        UIApplication.shared.isNetworkActivityIndicatorVisible=false
                    }
                    
                    print(self.movieTitlesArray)
                  
                    
                    
                }catch{
                    
                    print("error")
                    
                }
                
                
                
            }
            
            task.resume()
            

            
        }else{
            
           print("phone is not connected to the internet , Data will be loaded from coreData")
            movieImagesArray = []
            movieTitlesArray = []
            movieGenreArray = []
            movieRatingsArray = []
            movieReleaseDatesArray = []
            
            for index in 0 ... (movies.count-1){
                
                movieTitlesArray.append(movies[index].value(forKey: "movieTitle") as! String)
                movieImagesArray.append(movies[index].value(forKey: "movieImageName") as! String)
                movieRatingsArray.append(movies[index].value(forKey: "movieRating") as! Float)
//                movieReleaseDatesArray.append(movies[index].value(forKey: "movieReleaseYear") as! Int)
               
                
            }
            
            
            
            
            
            
            
        }
 
        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
//        let myPredicate = NSPredicate(format: "movieTitle == %@", "Dawn of the Planet of the Apes")
//
//        fetchRequest.predicate = myPredicate
//
//        do{
//
//            movies = try managedContext.fetch(fetchRequest)
//
//        }catch let error as NSError{
//
//            print(error)
//        }
//
//
        
}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieTitlesArray.count
    }
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let managedContext = appdelegate.persistentContainer.viewContext
        
        
        
        
        let cellLabel : UILabel = cell.viewWithTag(2) as! UILabel
        let cellImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        
//        cell.textLabel?.text = movies[indexPath.row].value(forKey: "title") as! String

     //    cellLabel.text = movies[indexPath.row].value(forKey: "movieTitle") as! String
        cellImage.sd_setImage(with: URL(string: movieImagesArray[indexPath.row]), placeholderImage: UIImage(named: "loading.png"))
        cellLabel.text = movieTitlesArray[indexPath.row] as! String
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! MovieInfoViewController
        
        vc.movieTitleLabel = movieTitlesArray[indexPath.row] as! String
//        vc.movieReleaseDateLabel=Int64(movieReleaseDatesArray[indexPath.row] as! Int)
        vc.movieImageName=movieImagesArray[indexPath.row]
        vc.movieRatingLabel=movieRatingsArray[indexPath.row]
        vc.movieGenreArr = self.movies[indexPath.row].value(forKey: "movieGenre") as! [String]
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
    }
    
    
    
    
    }


