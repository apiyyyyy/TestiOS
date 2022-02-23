//
//  Model.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import Foundation
import SwiftyJSON

struct MovieResponse: Codable {
    
    var results: [Movie]
    
    init(results: [Movie]){
        self.results = results
    }
    
    init(data: JSON){
        let results_ = data["results"].array ?? []
        self.results = []
        for i in 0..<results_.count{
            results.append(Movie.init(json: results_[i]))
        }
    }
}

struct Movie: Codable {
    
    let id: Int
    let title: String
    let backdropPath: String
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let genre_ids : [Int]
    let release_date : String
    var genres : [Genres]
    
    init(json: JSON){
        self.id = json["id"].int ?? 0
        self.title = json["title"].string ?? ""
        self.backdropPath = json["backdrop_path"].string ?? ""
        self.posterPath = json["poster_path"].string ?? ""
        self.overview = json["overview"].string ?? ""
        self.voteAverage = json["vote_average"].double ?? 0
        self.voteCount = json["vote_count"].int ?? 0
        self.runtime = json["runtime"].int ?? 0
        self.genre_ids = json["genre_ids"].arrayObject as? [Int] ?? []
        self.release_date = json["release_date"].string ?? ""
        let genres_ = json["genres"].array ?? []
        
        self.genres = []
        for i in 0..<genres_.count{
            genres.append(Genres.init(json: genres_[i]))
        }
    }
    
    init(id:Int, title:String, backdrop_path: String, poster_path:String, overview: String, vote_average: Double, vote_count: Int, runtime: Int, genre_ids: [Int], release_date:String, genres:[Genres]){
        self.id = id
        self.title = title
        self.backdropPath = backdrop_path
        self.posterPath = poster_path
        self.overview = overview
        self.voteAverage = vote_average
        self.voteCount = vote_count
        self.runtime = runtime
        self.genre_ids = genre_ids
        self.release_date = release_date
        self.genres = genres
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath )")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}

struct Genres: Codable {
    
    let id : Int
    let name : String
    
    init(id:Int, name:String) {
        self.name = name
        self.id = id
        
    }
    
    init(json: JSON) {
        self.id = json["id"].int ?? 0
        self.name = json["name"].string ?? ""
    }
}

struct Reviews: Codable {
    let author : String
    let content: String
    let created_at : String
    let url : String
    
    init(json: JSON) {
        self.author = json["author"].string ?? ""
        self.content = json["content"].string ?? ""
        self.created_at = json["created_at"].string ?? ""
        self.url = json["url"].string ?? ""
    }
}

struct Videos: Codable {
    let key : String
    let name : String
    let site : String
    let type : String
    
    init(json: JSON) {
        self.key = json["key"].string ?? ""
        self.name = json["name"].string ?? ""
        self.site = json["site"].string ?? ""
        self.type = json["type"].string ?? ""
    }
    
    var youtubeURL: URL? {
        guard site == "Youtube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
