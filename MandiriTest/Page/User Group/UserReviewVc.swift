//
//  UserReviewVc.swift
//  MandiriTest
//
//  Created by Afi Permana on 23/02/22.
//

import UIKit

class UserReviewVc: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    let userReviewVm = UserReviewVm()

    override func viewDidLoad() {
        super.viewDidLoad()

        getReviewList()
        
        reviewTableView.estimatedRowHeight = 185
        reviewTableView.rowHeight = UITableView.automaticDimension
    }
    
    func getReviewList(){
        userReviewVm.getReview(id: userReviewVm.id) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.reviewTableView.reloadData()
                }
            }
        }
    }
}

extension UserReviewVc : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReviewVm.reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = userReviewVm.reviewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath)as! ReviewTableViewCell
        
        cell.authorLabel.text = data.author
        cell.reviewLabel.text = data.content
        
        return cell
    }
    
    
}


class ReviewTableViewCell : UITableViewCell {
    
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
}
