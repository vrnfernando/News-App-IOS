//
//  CategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //Outlet: UIButton
    @IBOutlet weak var btn_category: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius  = 10
        btn_category.layer.cornerRadius = 10
        btn_category.sizeToFit()
    }

}
