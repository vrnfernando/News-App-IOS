//
//  ViewController.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-20.
//

import UIKit

class ViewController: UIViewController {
    
    //Network
    var httpService:HTTPService!
    
    //Outlet: UISearchBar
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Outlet: UICollectionView
    @IBOutlet weak var collectionView_latestNews: UICollectionView!
    @IBOutlet weak var collectionView_category: UICollectionView!
    @IBOutlet weak var collectionView_bottomCategory: UICollectionView!
    
    //Outlet: UIView
    @IBOutlet weak var view_bottomNavigation: UIView!
    
    var articalArray: [Article] = []
    var allArticalNewsArray: [Article] = []
    var categoryArray:[String] = ["Healthy","Technology","Finance","Arts","Sport"]
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hide Navigation Bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self

        // collectionView Cell
        collectionView_latestNews?.contentInsetAdjustmentBehavior = .always
        collectionView_latestNews.register(UINib(nibName: "LatestNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestNewsCollectionViewCell")
        collectionView_latestNews.isPagingEnabled = true
        
        collectionView_category?.contentInsetAdjustmentBehavior = .always
        collectionView_category.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView_category.allowsSelection = true
        
        collectionView_bottomCategory?.contentInsetAdjustmentBehavior = .always
        collectionView_bottomCategory.register(UINib(nibName: "BottomCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BottomCategoryCollectionViewCell")
        
        //Network Request
        httpService = HTTPService(baseUrl: "https://newsapi.org")
        httpService.getLatestNews()
        httpService.getAllNews()
        httpService.dashBoardDelegate = self

        self.collectionView_category.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    override func viewDidLayoutSubviews() {
        setUpUI()
    }
    
    
    func setUpUI(){
        
        // search Bar additional setup
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        SearchText(to: searchBar, placeHolderText: "Dogecoin to the Moon...")
        
        view_bottomNavigation.layer.cornerRadius = 25
    }

}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView_latestNews {
            return articalArray.count
        }else if  collectionView == collectionView_bottomCategory{
            return allArticalNewsArray.count
        }

        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let latestNewsCell = collectionView_latestNews.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as! LatestNewsCollectionViewCell
        let categoryCell   = collectionView_category.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let bottomCategory = collectionView_bottomCategory.dequeueReusableCell(withReuseIdentifier: "BottomCategoryCollectionViewCell", for: indexPath) as!      BottomCategoryCollectionViewCell
        
        if collectionView == collectionView_latestNews {
            
            latestNewsCell.lb_author.text = articalArray[indexPath.row].author as? String
            latestNewsCell.lb_title.text  = articalArray[indexPath.row].title  as? String
            latestNewsCell.lb_description.text = articalArray[indexPath.row]._description as? String
            latestNewsCell.loadFrom(URLAddress: articalArray[indexPath.row].urlToImage as String)
            
           return latestNewsCell
        }else if  collectionView == collectionView_bottomCategory{
            bottomCategory.lb_name.text  = allArticalNewsArray[indexPath.row].source.name as? String
            bottomCategory.lb_date.text  = allArticalNewsArray[indexPath.row].publishedAt as? String
            bottomCategory.lb_topic.text = allArticalNewsArray[indexPath.row].title as? String
            bottomCategory.loadFrom(URLAddress: allArticalNewsArray[indexPath.row].urlToImage as String)
            return bottomCategory
        }
        
        categoryCell.btn_category.setTitle(categoryArray[indexPath.row], for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionView_category {
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if collectionView == collectionView_category {
            
            
        }
        
    }
    
}


extension ViewController: DashBoardAPIDelegate{
    func getAllNews(res: [Article]) {
        allArticalNewsArray = res
        collectionView_bottomCategory.reloadData()
    }
    
    func getAllNews(_ error: RestClientError) {
        showAlert(alertText: "Error", alertMessage: "\(error)")
    }
    
    func getLatestNews(res: [Article]) {
        print(res)
        articalArray = res
        collectionView_latestNews.reloadData()
    }
    
    func getLatestNews(_ error: RestClientError) {
       showAlert(alertText: "Error", alertMessage: "\(error)")
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(nextViewController, animated:false)
        
        searchBar.endEditing(true) // End SearchBar DidBeginEditing
        
    }
}
