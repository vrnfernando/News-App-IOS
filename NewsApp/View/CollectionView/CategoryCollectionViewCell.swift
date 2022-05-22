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
    
    override var isSelected: Bool {
        didSet {
            setUpCellUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btn_category.isUserInteractionEnabled = false
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius  = 10
        btn_category.layer.cornerRadius = 10
        btn_category.sizeToFit()
    }
    
    func setUpCellUI() {
        if isSelected {
        
            contentView.backgroundColor = #colorLiteral(red: 1, green: 0.2274509804, blue: 0.2666666667, alpha: 1)
            btn_category.tintColor = UIColor.white

        } else {
            contentView.backgroundColor = #colorLiteral(red: 1, green: 0.2274509804, blue: 0.2666666667, alpha: 0)
            btn_category.tintColor = UIColor.gray
        }
    }
}
