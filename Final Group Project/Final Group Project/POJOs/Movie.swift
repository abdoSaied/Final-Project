//
//  Movie.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/8/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import Foundation
class Movie
{
    var title:String
    var relesedYear:String
    var rate:Float
    var image:String
    var backgroundImage:String
    var stroyLine:String
    var genre:[String]
    init()
    {
        self.title = ""
        self.relesedYear = ""
        self.rate = 0.0
        self.image = ""
        self.genre = [""]
        self.backgroundImage = ""
        self.stroyLine = ""
    }
    init(title:String,rate:Float,image:String,genre:[String],relesedYear:String,backgroundImage:String,stroyLine:String)
    {
        self.title = title
        self.rate = rate
        self.image = image
        self.genre = genre
        self.relesedYear = relesedYear
        self.backgroundImage = backgroundImage
        self.stroyLine = stroyLine
    }
}
