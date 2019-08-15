//
//  CollectionViewContract.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/8/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import Foundation
protocol ICollectionView:IBase{
    func renderingTable(Movies:[Movie])
}



protocol IColectionPresenter{
    func getMovie(flage:Bool)
    func onSuccess(Movies:[Movie])
    func OnFaild(errorMessgae : String)
}
protocol ICollectionManger {
    func getMovie(flage:Bool)
}
