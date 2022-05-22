//
//  LatestNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-21.
//

import UIKit
import AlamofireImage
import SDWebImage

class LatestNewsCollectionViewCell: UICollectionViewCell {
    
    //Outlet: UIView
    @IBOutlet weak var view_image: UIView!
    
    //Outlet: UILabel
    @IBOutlet weak var lb_author: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_description: UILabel!
    
    var loadImage: UIImageView =  UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
    }
    
    
    func populateCell(_ image: UIImage) {
        
        //          set def background image
        UIGraphicsBeginImageContext(view_image.layer.frame.size)
        UIImage(named: "man")?.draw(in: view_image.layer.bounds)
        
        let imageOne: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let size = CGSize(width: view_image.layer.frame.size.width, height:view_image.layer.frame.size.height )
        let aspectScaledToFitImage = image.af_imageAspectScaled(toFill: size)
        
        view_image.backgroundColor = UIColor(patternImage: imageOne)
        view_image.backgroundColor = UIColor(patternImage: aspectScaledToFitImage)
    
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

