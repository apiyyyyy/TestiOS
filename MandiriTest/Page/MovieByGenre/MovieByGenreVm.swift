//
//  MovieByGenreVm.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import Foundation


class MovieByGenreVm {
    
    
    let service = APIServer.shared
    var idGenre = 0
    var genreName = ""
    var movieList : [Movie] = []
    
    func getMovieListByGenre(endpoint: Int, completion: @escaping (Int?) -> ()){
        
        service.getMovieGenreList(endpoint: endpoint) { json, statusCode in
            
            if statusCode == 200 {
                for i in 0..<json.count{
                    self.movieList.append(Movie.init(json: json[i]))
                }
            }
            completion(statusCode)
        }
    }
}
