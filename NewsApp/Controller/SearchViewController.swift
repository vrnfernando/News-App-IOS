//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-22.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate, UISearchBarDelegate {
    
    //Network
    var httpService:HTTPService!
    
    //Outlet: UICollectionView
    @IBOutlet weak var collection_category: UICollectionView!
    @IBOutlet weak var collection_result: UICollectionView!
    
    //Outlet: UISearchBar
    @IBOutlet weak var searchBar: UISearchBar!
    
    var categoryArray:[String] = ["Filter","Technology","Finance","Arts","Sport"]
    
    var allArticals:[Article] = []
    var currentArticalArray: [Article] = [] // update collection
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collection_category?.contentInsetAdjustmentBehavior = .always
        collection_category.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collection_category.allowsSelection = true
        
        collection_result?.contentInsetAdjustmentBehavior = .always
        collection_result.register(UINib(nibName: "BottomCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BottomCategoryCollectionViewCell")
        collection_result.isPrefetchingEnabled = true
        
        //Network Request
        httpService = HTTPService(baseUrl: "https://newsapi.org")
        httpService.getSearchNews()
        httpService.searchAPIDelegate = self
        
        setUpSearchBar()
        
        self.collection_category.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpSearchBar(){
        
        searchBar.delegate = self
        // search Bar additional setup
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        SearchText(to: searchBar, placeHolderText: "Dogecoin to the Moon...")
        
        
    }
    
    //filter data
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentArticalArray = allArticals
            collection_result.reloadData()
            return
        }
        currentArticalArray = allArticals.filter({ artical -> Bool in
             artical.title.contains(searchText)
        })
        collection_result.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("")
    }
    
    // Move to detail View
    func moveToDescriptionView(artical: Article){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextViewController.artical = artical
        self.navigationController?.pushViewController(nextViewController, animated:false)
        
    }

}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView == collection_result{
            return currentArticalArray.count
        }

        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let categoryCell   = collection_category.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let bottomCategory = collection_result.dequeueReusableCell(withReuseIdentifier: "BottomCategoryCollectionViewCell", for: indexPath) as!      BottomCategoryCollectionViewCell
        
         if  collectionView == collection_category{
             categoryCell.btn_category.setTitle(categoryArray[indexPath.row], for: .normal)
            return categoryCell
        }
        
        bottomCategory.lb_name.text  = currentArticalArray[indexPath.row].source.name as? String
        bottomCategory.lb_date.text  = currentArticalArray[indexPath.row].publishedAt as? String
        bottomCategory.lb_topic.text = currentArticalArray[indexPath.row].title as? String
        bottomCategory.loadFrom(URLAddress: currentArticalArray[indexPath.row].urlToImage as String)
        
     
        return bottomCategory
    }
    
    // Set CollectionViewCell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:  UICollectionViewLayout, sizeForItemAt indexPath:    IndexPath) -> CGSize {
        
        let sizeTotal:CGSize!
        
       if  collectionView == collection_result{
            
            sizeTotal = CGSize(width:((self.collection_result.frame.size.width) ),height: self.collection_result.frame.size.height/5)
            
            return sizeTotal
        }
        
        sizeTotal = CGSize(width:((self.collection_category.frame.size.width/4) ),height: self.collection_category.frame.size.height)

        return sizeTotal
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collection_category {
        }else{
            moveToDescriptionView(artical: currentArticalArray[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if collectionView == collection_category {
        }
        
    }
    
}

extension SearchViewController: SearchAPIDelegate {
    func getSearchList(res: [Article]) {
        allArticals = res
        currentArticalArray = allArticals
        collection_result.reloadData()
    }
    
    func getSearchList(_ error: RestClientError) {
        showAlert(alertText: "Error", alertMessage: "\(error)")
    }
    
}
