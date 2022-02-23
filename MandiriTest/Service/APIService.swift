//
//  APIService.swift
//  MandiriTest
//
//  Created by Afi Permana on 19/02/22.
//
import Foundation
import SwiftyJSON
import Alamofire

class APIServer {
    
    static let shared = APIServer()
    
    func getMovieGenreList(endpoint: Int, completion: @escaping(JSON,Int?) -> ()) {
        
        AF.request(MOVIE_GENRE_LIST + "\(endpoint)", method: .get, parameters: apiKeys).responseData { response in
            switch response.result{
            case.success:
                let json = JSON(response.data!)
                let statusCode = response.response?.statusCode
                let data = json["results"]
                completion(data, statusCode)
            case.failure :
                print("failed")
            }
        }
    }
    
    func getMovieDetail(id: Int, completion: @escaping(Movie, Int?) -> ()){
        AF.request(MOVIE_DETAIL + "\(id)", method: .get, parameters: apiKeys).responseData { response in
            let json = JSON(response.data!)
            switch response.result {
            case.success:
                let statusCode = response.response?.statusCode
                print("data getMovieDetail \(json)")
                
                let data = Movie.init(json: json)
                completion(data, statusCode)
                
            case.failure :
                print("failed \(json)")
            }
        }
    }
    
    func getGenre(completion: @escaping(JSON, Int?) -> ()) {
        AF.request(MOVIEGENRE, method: .get, parameters: apiKeys).responseData { response in
            let json = JSON(response.data!)
            switch response.result {
            case.success:
                let data = json["genres"]
                let statusCode = response.response?.statusCode
                completion(data, statusCode)
                
            case.failure :
                print("error getGenre json\(json)")
            }
        }
    }
    
    func getMovieReviews(id: Int, completion: @escaping(JSON, Int?) -> ()){
        AF.request(MOVIES_REVIEWS + "\(id)/reviews", method: .get, parameters: apiKeys).responseData { response in
            switch response.result{
            case.success:
                let json = JSON(response.data!)
                let statusCode = response.response?.statusCode
                let data = json["results"]
                completion(data, statusCode)
            case.failure :
                print("failed")
            }
        }
    }
    func getMovieClip(id: Int, completion: @escaping(JSON, Int?) -> ()){
        AF.request(MOVIES_REVIEWS + "\(id)/videos", method: .get, parameters: apiKeys).responseData { response in
            switch response.result{
            case.success:
                let json = JSON(response.data!)
                let statusCode = response.response?.statusCode
                let data = json["results"]
                completion(data, statusCode)
            case.failure :
                print("failed")
            }
        }
    }
}
