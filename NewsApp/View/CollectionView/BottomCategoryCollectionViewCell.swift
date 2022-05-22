//
//  BottomCategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import UIKit
import SDWebImage

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

    func populateCell(_ image: UIImage) {
        
        //          set def background image
        UIGraphicsBeginImageContext(cardView.layer.frame.size)
        UIImage(named: "man")?.draw(in: cardView.layer.bounds)
        
        let imageOne: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let size = CGSize(width: cardView.layer.frame.size.width, height:cardView.layer.frame.size.height )
        let aspectScaledToFitImage = image.af_imageAspectScaled(toFill: size)
        
        cardView.backgroundColor = UIColor(patternImage: imageOne)
        cardView.backgroundColor = UIColor(patternImage: aspectScaledToFitImage)
    
    }
    
    func loadFrom(URLAddress: String) {
        
        SDWebImageManager.shared().loadImage(with: NSURL.init(string: URLAddress) as URL?, options: .continueInBackground, progress: { (recieved, expected, nil) in
            print(recieved,expected)
        }, completed: { (downloadedImage, data, error, SDImageCacheType, true, imageUrlString) in
            DispatchQueue.main.async {
                if downloadedImage != nil{
                    self.populateCell(downloadedImage!)
                }
            }
        })
    }
}
