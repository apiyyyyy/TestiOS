//
//  UserReviewVm.swift
//  MandiriTest
//
//  Created by Afi Permana on 23/02/22.
//

import Foundation
import SwiftyJSON


class UserReviewVm {
    
    let service = APIServer.shared
    var reviewList : [Reviews] = []
    var id = 0
    
    
    func getReview(id: Int, completion: @escaping (Int?)-> ()){
        service.getMovieReviews(id: id) { json, statusCode in
            
            if statusCode == 200 {
                
                for i in 0..<json.count {
                    self.reviewList.append(Reviews.init(json: json[i]))
                }
            }
            completion(statusCode)
        }
    }
    
    
}
