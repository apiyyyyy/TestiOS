//
//  RESTConfig.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import Foundation
import SwiftyJSON


let BASEAPI = "https://api.themoviedb.org/3/"

let MOVIE_DETAIL = BASEAPI + "movie/"
let MOVIEGENRE = BASEAPI + "genre/movie/list?language=en"
let MOVIE_GENRE_LIST = BASEAPI + "discover/movie?with_genres="
let MOVIES_REVIEWS = MOVIE_DETAIL

let ERRORMESSAGE = "API ERROR"

let apiKeys : [String:String] = [
    "api_key" : "2a7f3ada563417c9d55686d675453f34"
]

