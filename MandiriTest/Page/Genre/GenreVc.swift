//
//  GenreVc.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import UIKit

class GenreVc: UIViewController {
    
    @IBOutlet weak var genreTableView: UITableView!
    

    let genreVM = GenreVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUi()
        
    }

    func prepareUi() {
        genreTableView.dataSource = self
        genreTableView.delegate = self
        fetchGenre()
    }
    
    func fetchGenre() {
        genreVM.getGenre { statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.genreTableView.reloadData()
                }
            }else{
                showAlertDismiss(title: "Network Error", message: "Network Error, please try again later", view: self)
            }
        }
    }
}

extension GenreVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreVM.genreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell", for: indexPath) as! GenreTableViewCell
        let data = genreVM.genreList[indexPath.row]
        
        cell.genreLabel.text = data.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = genreVM.genreList[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieByGenreVc")as! MovieByGenreVc
        vc.movieVm.idGenre = data.id
        vc.movieVm.genreName = data.name
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    
}

