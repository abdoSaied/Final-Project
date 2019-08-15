//
//  MoviesCollectionController.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/8/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
var Moviess = [Movie]()
var flage = Bool()
class MoviesCollectionController: UICollectionViewController ,ICollectionView {
    func renderingTable(Movies: [Movie]) {
        Moviess = Movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        flage = true
        let Presenter = CollectionViewPresenter(withCollectionView:self)
        Presenter.getMovie(flage:flage)
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Moviess.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let myimage:UIImageView =  cell.viewWithTag(5) as! UIImageView
        if(flage == true)
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
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sce:PresentMoviesController = self.storyboard?.instantiateViewController(withIdentifier:"v2") as! PresentMoviesController
        sce.movie = Moviess[indexPath.row]
        sce.flage = flage
        self.navigationController?.pushViewController(sce, animated: true)
    }
    
    
}


