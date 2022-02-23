//
//  MovieDetailsVm.swift
//  MandiriTest
//
//  Created by Afi Permana on 23/02/22.
//

import Foundation
import SwiftyJSON


class MovieDetailVm {
    
    let service = APIServer.shared
    var movieDetails : Movie?
    var videoDetails : [Videos] = []
    var idMovie = 0
    
    func getMovieDetails(id: Int, completion : @escaping(Int?) -> ()){
        
        service.getMovieDetail(id: id) { json, statusCode in
            if statusCode == 200 {
                
                self.movieDetails = json
            }
            print("backdrop url \(self.movieDetails?.backdropURL)")
            completion(statusCode)
        }
    }
    
    func getMovieClip(id:Int, completion: @escaping(Int?) -> ()){
        service.getMovieClip(id: id) { json, statusCode in
            if statusCode == 200 {
                
                for i in 0..<json.count {
                    self.videoDetails.append(Videos.init(json: json[i]))
                }
                print("youtube url \(self.videoDetails[0].youtubeURL)")
            }
            completion(statusCode)
        }
    }
}
