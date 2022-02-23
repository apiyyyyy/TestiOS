//
//  MovieDetailsVc.swift
//  MandiriTest
//
//  Created by Afi Permana on 23/02/22.
//

import UIKit

class MovieDetailsVc: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var trailerTableView: UITableView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    let movieDetailVm = MovieDetailVm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieDetails()
        getVideo()
    }
    
    @IBAction func UserReviewSegue(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserReviewVc")as! UserReviewVc
        vc.userReviewVm.id = movieDetailVm.idMovie
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func getMovieDetails() {
        movieDetailVm.getMovieDetails(id: movieDetailVm.idMovie) { statusCode in
            if statusCode == 200 {
                self.prepareUi()
            }else {
                showAlertDismiss(title: "Failed", message: "Network Error, please try again later", view: self)
            }
        }
    }
    
    func getVideo() {
        movieDetailVm.getMovieClip(id: movieDetailVm.idMovie) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.trailerTableView.reloadData()
                }
            }
        }
    }
    
    func prepareUi() {
        let details = self.movieDetailVm.movieDetails

        self.releaseDateLabel.text = details?.release_date
        self.overviewLabel.text = details?.overview
        self.genreLabel.text = details?.genres[0].name
        self.ratingLabel.text = "\(details?.voteAverage ?? 0.0)/10"
        self.navigationItem.title = details?.title
        
        if let data = try? Data(contentsOf: details!.backdropURL){
            self.posterImage.image = UIImage(data: data)
        }
    }
    
    
    
    
}

extension MovieDetailsVc : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailVm.videoDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerTableViewCell", for: indexPath)as! TrailerTableViewCell
        let data = movieDetailVm.videoDetails[indexPath.row]
        
            cell.titleLabel.text = data.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = movieDetailVm.videoDetails[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeVc")as! YoutubeVc
        vc.key = data.key
        
        self.present(vc, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


class TrailerTableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playImage: UIImageView!
    
}
