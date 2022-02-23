//
//  GenreVM.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import Foundation
import SwiftyJSON


class GenreVM {
    
    let service = APIServer.shared
    
    var genreList : [Genres] = []
    
    func getGenre(completion: @escaping (Int?) -> ()) {
        service.getGenre { data, statusCode  in
            
            if statusCode == 200 {
                for i in 0..<data.count {
                    self.genreList.append(Genres.init(json: data[i]))
                }
            }
            completion(statusCode)
        }
    }
    
}
