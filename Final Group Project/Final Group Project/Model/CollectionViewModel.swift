//
//  CollectionViewModel.swift
//  Final Group Project
//
//  Created by Abdelrhman on 8/8/19.
//  Copyright © 2019 Abdelrhman. All rights reserved.
//

import Foundation
class CollectionViewModel
{
    var genreDic = NSMutableDictionary()
    var Movies:[Movie] = [Movie]()
        func getMoviesGenre(callback:@escaping (_ finsh:NSMutableDictionary) -> Void)
        {
            let url1 = URL(string:"https://api.themoviedb.org/3/genre/movie/list?api_key=20b87a6e1f2e31b531d78867cfe65e34&language=en-US")
            let req = URLRequest(url:url1!)
            let session = URLSession(configuration:URLSessionConfiguration.default)
            let task = session.dataTask(with:req){(data,respond,error)
                
                in
                
                do
                {
                    let json = try JSONSerialization.jsonObject(with:data!,   options:.allowFragments) as! NSDictionary
                    let result = json["genres"] as! [NSDictionary]
                    for item in result
                    {
                        let str = String(item["id"] as! Int)
                        self.genreDic.setValue(item["name"] as! String, forKey:str)
                    }
                    callback(self.genreDic)
                    
                    
                }catch
                {
                    print("Erorr")
                }
            
        }
        task.resume()
    }
    func getMoivesFromApi(callback:@escaping (_ finsh:[Movie]) -> Void)
        {
            let Dic : NSDictionary = [10402:"Music",10749:"Romance",10751:"Family",10752:"War",10770:"TV Movie",12:"Adventure",14:"Fantasy",16:"Animation",18:"Drama",27:"Horror",28:"Action",35:"Comedy",36:"History",37:"Western",53:"Thriller",80:"Crime",878:"Science Fiction",9648:"Mystery",99:"Documentary"]
            
                let url1 = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=20b87a6e1f2e31b531d78867cfe65e34")
                let req = URLRequest(url:url1!)
                let session = URLSession(configuration:URLSessionConfiguration.default)
                let task = session.dataTask(with:req){(data,respond,error)
                    
                    in
                    
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with:data!,   options:.allowFragments) as! NSDictionary
                        let result = json["results"] as! [NSDictionary]
                        for item in result
                        {
                            if(item["id"] as! Int == 616627)
                            {
                                continue
                            }else
                            {
                                if let n = item["vote_average"] as? NSNumber {
                                    let f = n.floatValue
                                    let imageURL = "http://image.tmdb.org/t/p/w185" + (item["poster_path"] as! String)
                                    let back = "http://image.tmdb.org/t/p/w500" + (item["backdrop_path"] as! String)
                                    var genre = [String]()
                                    
                                    for iteme in item["genre_ids"] as! [Int]
                                    {
                                        genre.append(Dic[iteme] as! String)
                                    }
                                    let mov:Movie = Movie(title:item["title"] as! String, rate: f, image:imageURL, genre:genre, relesedYear:item["release_date"] as! String,backgroundImage:back,stroyLine:item["overview"] as! String)
                                    self.Movies.append(mov)
                                    callback(self.Movies)
                                }
                            }
                            
                        }
                        
                    }catch
                    {
                        print("Error")
                        
                    }
                }
                task.resume()
                
            
    }

}
