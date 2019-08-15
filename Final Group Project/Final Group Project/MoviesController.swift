//
//  MoviesController.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/11/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import UIKit
import Alamofire
private let reuseIdentifier = "Cell"

var searchBare = UISearchBar()
var button = UIBarButtonItem()
var button2 = UIBarButtonItem()

var Moviess = [Movie]()
var titless = [String]()
var flage = Bool()
var searchMovieArr = [Movie]()
class MoviesController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,ICollectionView{
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var SearchButton: UIBarButtonItem!
    @IBOutlet weak var myCollectionView: UICollectionView!
    var Searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        myCollectionView = self.view.viewWithTag(6) as? UICollectionView
        flage = true
        let Presenter = CollectionViewPresenter(withCollectionView:self)
        Presenter.getMovie(flage:flage)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        searchBare.delegate = self
        searchBare.searchBarStyle = UISearchBar.Style.minimal
        button = SearchButton
        button2 = backButton
        self.navigationItem.leftBarButtonItem = nil
    }
    func showSearchBar() {
        self.navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBare
        self.navigationItem.leftBarButtonItem = button2
    }
    
    func hideSearchBar() {
        self.navigationItem.rightBarButtonItem = button
        navigationItem.titleView = nil
        self.navigationItem.leftBarButtonItem = nil
    }
    
    
    
    func renderingTable(Movies: [Movie]) {
        Moviess = Movies
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
        
    }
    
    func showLoading(flage:Bool) {
        if(flage == true)
        {
            let a:UIAlertController = UIAlertController(title:"Connection" , message: "Network is Working", preferredStyle:.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            a.addAction(defaultAction)
            self.present(a, animated: true, completion: nil)
        }else
        {
            let b = UIAlertController(title:"Connection", message:"Network is not Working", preferredStyle:.alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            b.addAction(defaultAction)
            self.present(b, animated: true, completion: nil)
        }
    }
    
    func errorMasseage(error: String) {
        let b = UIAlertController(title:"Error !", message:"Erorr in getting Data", preferredStyle:.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        b.addAction(defaultAction)
        self.present(b, animated: true, completion: nil)
    }
    
    
    
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Searching
        {
            return searchMovieArr.count
        }else
        {
            return Moviess.count
        }
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let myimage:UIImageView =  cell.viewWithTag(5) as! UIImageView
        if(flage == true)
        {
            if Searching
            {
                if let url2 = URL(string:searchMovieArr[indexPath.row].image)
                {
                    do
                    {
                        
                        
                        let datae:Data = try Data.init(contentsOf:url2)
                        myimage.image = UIImage.init(data:datae as Data)
                    }catch
                    {
                        print("Error!")
                    }
                }
            }else
            {
                if let url2 = URL(string:Moviess[indexPath.row].image)
                {
                    do
                    {
                        
                        
                        let datae:Data = try Data.init(contentsOf:url2)
                        myimage.image = UIImage.init(data:datae as Data)
                    }catch
                    {
                        print("Error!")
                    }
                }
            }
            
        }
        
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sce:PresentMoviesController = self.storyboard?.instantiateViewController(withIdentifier:"v2") as! PresentMoviesController
        if Searching
        {
            sce.movie = searchMovieArr[indexPath.row]
        }else
        {
            sce.movie = Moviess[indexPath.row]
            sce.Movies = Moviess
        }
        
        sce.flage = flage
        self.navigationController?.pushViewController(sce,animated:true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovieArr = Moviess.filter({$0.title.prefix(searchText.count).lowercased() == searchText.lowercased()})
        Searching = true
        myCollectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Searching = false
        myCollectionView.reloadData()
    }
    @IBAction func SearchButton(_ sender: UIBarButtonItem) {
        showSearchBar()
    }
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        hideSearchBar()
    }
}
