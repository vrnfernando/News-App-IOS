//
//  BottomCategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import UIKit

class BottomCategoryCollectionViewCell: UICollectionViewCell {
    
    //Outlet: UIView
    @IBOutlet weak var cardView: UIView!
    
    //Outlet: UILabel
    @IBOutlet weak var lb_topic: UILabel!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10.0
    }

}
