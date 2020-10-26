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

class MoviesCollectionVC: UIViewController {
 
     @IBOutlet weak var myCollectionView: UICollectionView!
    
    let reachabilityManager                 = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        var movieTitlesArray    :[String]   = []
    var movieReleaseDatesArray  :[Int]      = []
    var movieRatingsArray       :[Float]    = []
    var movieImagesArray        :[String]   = []
    var movieGenreArray         :[String]   = []
    var downloadedMoviesArray   : [Film]    = []

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        reachabilityManager?.startListening()
        
        if NetworkReachabilityManager()!.isReachable == true {
            print("phone is connected to the internet")

            NetworkManager.shared.getMoviesList { [weak self] result in
                
                guard let self = self else {return}
                switch result{
                case .success(let films):
                    print(films)
                    
                    self.downloadedMoviesArray = films
                    
                    DispatchQueue.main.async {
                        CoreDataManager.shared.DeleteAllData()

                        self.loopThroughMovies(films: films)
                        
                        self.myCollectionView.reloadData()
                    }
                    
                    
                case .failure(let error):
                    print(error.rawValue)
                    
                   break
                }
            }

        }else{
            
           print("phone is not connected to the internet , Data will be loaded from coreData")
        
            offlineRenderingData()

        }

        
}
    
    
    func loopThroughMovies(films : [Film]){
        for film in films {CoreDataManager.shared.saveInCoreData(film: film)}
    }
    
    
    func offlineRenderingData(){
        
        CoreDataManager.shared.fetchDataFromCoreData { (result) in
            switch result{
            case .failure(let error):
                print(error.rawValue)
                
            case .success(let movies):
                self.downloadedMoviesArray.removeAll()
                for movie in movies{
                    var film : Film!
                    film.genre = movie.value(forKey: "movieGenre") as! [String]
                    film.title = movie.value(forKey: "movieTitle") as! String
                    film.image = movie.value(forKey: "movieImageName") as! String
                    film.rating = movie.value(forKey: "movieRating") as! Double
                    film.releaseYear = movie.value(forKey: "movieReleaseYear") as! Int
                    self.downloadedMoviesArray.append(film)
                    
                }
                
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
                
                break
            }
        }
        
    }

}





extension MoviesCollectionVC : UICollectionViewDelegate , UICollectionViewDataSource {

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.downloadedMoviesArray.count
       }
    
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
       
           let cellLabel : UILabel = cell.viewWithTag(2) as! UILabel
           let cellImage : UIImageView = cell.viewWithTag(1) as! UIImageView
           
           cellImage.sd_setImage(with: URL(string: downloadedMoviesArray[indexPath.row].image), placeholderImage: UIImage(named: "loading.png"))
           
           cellLabel.text = downloadedMoviesArray[indexPath.row].title
           
           
           return cell
       }
       
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // CoreDataManager.shared.fetchDataFromCoreData()

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! MovieInfoVC

//        vc.movieTitleLabel = movieTitlesArray[indexPath.row]
//        //        vc.movieReleaseDateLabel=Int64(movieReleaseDatesArray[indexPath.row] as! Int)
//        vc.movieImageName=movieImagesArray[indexPath.row]
//        vc.movieRatingLabel=movieRatingsArray[indexPath.row]
//        vc.movieGenreArr = self.movies[indexPath.row].value(forKey: "movieGenre") as! [String]

        vc.film = downloadedMoviesArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    
        
//        let movieInfo = MovieInfoVC()
//        let navigationController = UINavigationController(rootViewController: movieInfo)
//        movieInfo.film = downloadedMoviesArray[indexPath.row]
//        present(navigationController, animated: true, completion: nil)


           }
       
}
