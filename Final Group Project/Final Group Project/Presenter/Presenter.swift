//
//  Presenter.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/8/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import Foundation
class CollectionViewPresenter:IColectionPresenter
{
    var CollectionView:ICollectionView
    init(withCollectionView CollectionView : ICollectionView) {
        
        
        self.CollectionView = CollectionView
        
    }
    
    func getMovie(flage:Bool) {
        CollectionView.showLoading(flage:flage)
        let model = CollectionViewModel()
        if(flage == true)
        {
            model.getMoivesFromApi(callback:{final  in
                if(final.count == 0)
                {
                    self.OnFaild(errorMessgae:"Cant Load Data")
                    
                }else
                {
                    self.onSuccess(Movies:final)
                    print("1")
                }
                
            })
        }
        
    }
    
    func onSuccess(Movies: [Movie]) {
        CollectionView.renderingTable(Movies:Movies)
    }
    
    func OnFaild(errorMessgae:String) {
        CollectionView.errorMasseage(error:errorMessgae)
        
    }
    
    
    
}
