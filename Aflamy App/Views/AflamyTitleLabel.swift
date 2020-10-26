//
//  GSTitleLabel.swift
//  GithubSearch
//
//  Created by Ahmad Sameh on 9/27/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import UIKit

class AflamyTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        textColor                                   = .darkText
        adjustsFontSizeToFitWidth                   = true
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontForContentSizeCategory           = true
        minimumScaleFactor                          = 0.9
        //if the text is bigger than the label
        lineBreakMode                               = .byTruncatingTail
        textAlignment = textAlignment
        font = UIFont.systemFont(ofSize: 22, weight: .bold)
 
    }
}
