//
//  CutsomConntainerView.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 10/26/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class CustomContainerView : UIView{
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        
        layer.cornerRadius = 20
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        } else {
            backgroundColor = .darkGray

        }
    }

}
