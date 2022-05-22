//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // Outlet: View
    @IBOutlet weak var view_image: UIView!
    @IBOutlet weak var view_center: UIView!
    @IBOutlet weak var view_description: UIView!
    
    // Outlet: UILabel
    @IBOutlet weak var lb_date: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var lb_author: UILabel!

    // Outlet: UITextView
    @IBOutlet weak var tf_description: UITextView!
    
    // Outlet: UIButton
    @IBOutlet weak var btn_fav: UIButton!
    
    var artical: Article!
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_description.layer.cornerRadius = 20
        view_center.layer.cornerRadius = 20
        btn_fav.layer.cornerRadius = 40
        tf_description.isEditable = false
        tf_description.isScrollEnabled = true
        
        lb_date.text = artical.publishedAt as? String
        lb_title.text = artical.title as? String
        lb_author.text = artical.author as? String
        tf_description.text = artical.content as? String
        loadFrom(URLAddress: artical.urlToImage as String)
        
    }
    
    
    func populateImage(_ image: UIImage) {
        
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
                            self.populateImage(downloadedImage!)
                        }
                    }
                })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
