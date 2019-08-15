//
//  PresentMoviesController.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/8/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import UIKit
import Cosmos
class PresentMoviesController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath)
        let myimage:UIImageView =  cell.viewWithTag(7) as! UIImageView
        if let url2 = URL(string:Movies[indexPath.row].image)
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
        return cell
    }
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var relesedYearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var ourImage: UIImageView!
    var Movies = [Movie]()
    var CosmoViewe:CosmosView = CosmosView()
    var movie:Movie = Movie()
    var flage = Bool()
    var images = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        CosmoViewe = self.view.viewWithTag(4) as! CosmosView
        CosmoViewe.settings.fillMode = .precise
        CosmoViewe.rating = Double(movie.rate) - 5.0
        CosmoViewe.settings.updateOnTouch = false
        if(flage == true)
        {
            if let url2 = URL(string:movie.image)
            {
                do
                {
                    
                    
                    let datae:Data = try Data.init(contentsOf:url2)
                    ourImage.image = UIImage.init(data:datae as Data)
                }catch
                {
                    print("Error!")
                }
            }
            
            if let url2 = URL(string:movie.backgroundImage)
            {
                do
                {
                    
                    
                    let datae:Data = try Data.init(contentsOf:url2)
                    myImage.image = UIImage.init(data:datae as Data)
                }catch
                {
                    print("Error!")
                }
            }
        }else
        {
            myImage.image = UIImage.init(named:images)
        }
        
        titleLabel.text = movie.title
        relesedYearLabel.text = movie.relesedYear
        myTextView.text = movie.stroyLine
        
    }
    
    
    
    
    
    
    

}
