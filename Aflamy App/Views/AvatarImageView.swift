////
////  GSImageView.swift
////  GithubSearch
////
////  Created by Ahmad Sameh on 10/1/20.
////  Copyright © 2020 Ahmad Sameh. All rights reserved.
////
//
//import UIKit
//
//class AvatarImageView: UIImageView {
//
//    let placeholderImage = Images.avatarPlaceholder
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    private func configure(){
//        layer.cornerRadius = 16
//        image              = placeholderImage
//        clipsToBounds      = true
//        translatesAutoresizingMaskIntoConstraints = false
//        
//    }
//    
//    func getImage(for urlText : String){
//        if let image = NetworkManager.shared.cache.object(forKey: NSString(string: urlText) ) {self.image = image}
//        
//        guard let url = URL(string: urlText) else {return}
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self else {return}
//            if error != nil {return}
//            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else {return}
//            guard let data = data else {return}
//            
//            guard let image = UIImage(data: data) else {return}
//            NetworkManager.shared.cache.setObject(image, forKey: NSString(string: urlText))
//            DispatchQueue.main.async {self.image = image}
//        }
//        task.resume()
//    }
//}
