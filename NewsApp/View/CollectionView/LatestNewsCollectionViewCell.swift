//
//  LatestNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-21.
//

import UIKit

class LatestNewsCollectionViewCell: UICollectionViewCell {
    
    //Outlet: UIView
    @IBOutlet weak var view_image: UIView!
    
    //Outlet: UILabel
    @IBOutlet weak var lb_author: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
    }

}
