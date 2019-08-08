//
//  MyCustomCollectionViewCell.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 8/7/19.
//  Copyright © 2019 Ahmad Sameh. All rights reserved.
//

import UIKit

class MyCustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!

    func setContent(image : UIImage , movieName : String){
        
        movieNameLabel.text = movieName
        myImageView.image = image
    }
}
