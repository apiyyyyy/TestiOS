//
//  MovieByGenreVc.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import UIKit

class MovieByGenreVc: UIViewController{

    @IBOutlet weak var movieGenreTableView: UITableView!
    
    let movieVm = MovieByGenreVm()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    func prepareUI(){
        getMovieList()
        
        self.navigationItem.title = movieVm.genreName
        self.movieGenreTableView.dataSource = self
        self.movieGenreTableView.delegate = self
//        self.movieGenreTableView.prefetchDataSource = self
        
    }
    
    func getMovieList(){
        
        movieVm.getMovieListByGenre(endpoint: movieVm.idGenre) { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.movieGenreTableView.reloadData()
                }
            }else{
                showAlertDismiss(title: "Network Error", message: "Network Error, please try again later", view: self)
            }
        }
    }
}

extension MovieByGenreVc: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieVm.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = movieVm.movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieGenreTableViewCell", for: indexPath) as! MovieGenreTableViewCell
        let imageUrl = data.backdropURL
        
        cell.titleLabel.text = data.title
        
        if let data = try? Data(contentsOf: imageUrl){
            cell.posterImage.image = UIImage(data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = movieVm.movieList[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVc")as! MovieDetailsVc
        
        vc.movieDetailVm.idMovie = data.id
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        if indexPaths.contains(where: isLoadingCell) {
//            getMovieList()
//          }
//    }
}

//private extension MovieByGenreVc {
//    func isLoadingCell(for indexPath: IndexPath) -> Bool {
//        return indexPath.row >= movieVm.movieList.count
//      }
//
//      func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
//        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
//        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
//        return Array(indexPathsIntersection)
//      }
//}

class MovieGenreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
}
