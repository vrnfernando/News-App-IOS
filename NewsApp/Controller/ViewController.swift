//
//  ViewController.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-20.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlet: UISearchBar
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Outlet: UICollectionView
    @IBOutlet weak var collectionView_latestNews: UICollectionView!
    @IBOutlet weak var collectionView_category: UICollectionView!
    @IBOutlet weak var collectionView_bottomCategory: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hide Navigation Bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // search Bar additional setup
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        SearchText(to: searchBar, placeHolderText: "Dogecoin to the Moon...")
        
        // collectionView Cell
        collectionView_latestNews?.contentInsetAdjustmentBehavior = .always
        collectionView_latestNews.register(UINib(nibName: "LatestNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestNewsCollectionViewCell")
        collectionView_latestNews.isPagingEnabled = true
        
        collectionView_category?.contentInsetAdjustmentBehavior = .always
        collectionView_category.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
        
        collectionView_bottomCategory?.contentInsetAdjustmentBehavior = .always
        collectionView_bottomCategory.register(UINib(nibName: "BottomCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BottomCategoryCollectionViewCell")

    }


    // Set Custom Search Field
    func SearchText(to searchBar: UISearchBar, placeHolderText: String) {
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        let searchTextField:UITextField = searchBar.value(forKey: "searchField") as? UITextField ?? UITextField()
        searchTextField.layer.cornerRadius = 18
        searchTextField.layer.borderWidth = 0.2
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.textAlignment = NSTextAlignment.left
      
        searchTextField.leftView = nil
        searchTextField.font = UIFont.systemFont(ofSize: 12.0)
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeHolderText,attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        let image:UIImage = UIImage(named: "ic_search")!
        let imageView:UIImageView = UIImageView.init(image: image)
        searchTextField.rightView = imageView
        searchTextField.backgroundColor = UIColor.white
        searchTextField.rightViewMode = UITextField.ViewMode.always
    }

}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView_latestNews {
            return 5
        }else if  collectionView == collectionView_bottomCategory{
            return 4
        }

        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let latestNewsCell = collectionView_latestNews.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as! LatestNewsCollectionViewCell
        let categoryCell   = collectionView_category.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let bottomCategory = collectionView_bottomCategory.dequeueReusableCell(withReuseIdentifier: "BottomCategoryCollectionViewCell", for: indexPath) as!      BottomCategoryCollectionViewCell
        
        if collectionView == collectionView_latestNews {
            
           return latestNewsCell
        }else if  collectionView == collectionView_bottomCategory{
            
            return bottomCategory
        }
        
        return categoryCell
    }
    
    // Set CollectionViewCell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:  UICollectionViewLayout, sizeForItemAt indexPath:    IndexPath) -> CGSize {
        
        let sizeTotal:CGSize!
        
        if collectionView == collectionView_latestNews {

            sizeTotal = CGSize(width:((self.collectionView_latestNews.frame.size.width/4) * 3 ),height: self.collectionView_latestNews.frame.size.height - 10)
            
            return sizeTotal
        }else if  collectionView == collectionView_bottomCategory{
            
            sizeTotal = CGSize(width:((self.collectionView_bottomCategory.frame.size.width) ),height: self.collectionView_bottomCategory.frame.size.height/3)
            
            return sizeTotal
        }
        
        sizeTotal = CGSize(width:((self.collectionView_category.frame.size.width/4) ),height: self.collectionView_category.frame.size.height)

        return sizeTotal
    }
    
}
