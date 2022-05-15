//
//  DetailPersonController.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.05.2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
 
    var presenter: DetailViewPresenterProtocol!
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    @IBOutlet weak var numberEpisodesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingSpinner.startAnimating()
        loadingSpinner.isHidden = false
    }
    
    func refresh(person: PersonDetail){
        title = person.name

        personImage.sd_setImage(with: URL(string: person.image)) {[weak self] _, error, _, _ in
            if error == nil {
                self?.loadingSpinner.stopAnimating()
                self?.loadingSpinner.isHidden = true
            }
        }
        speciesLabel.text = "Species: \(person.species)"
        genderLabel.text = "Gender: \(person.gender)"
        statusLabel.text = "Status: \(person.status)"
        lastLocationLabel.text = "Last location: \(person.location.name)"
        numberEpisodesLabel.text = "Episode count: \(person.episode.count)"
        
    }
}

extension DetailViewController: DetailViewProtocol{
    func succes() {
        guard let person = presenter.personDetail else { return }
        refresh(person: person)
    }
    
    func failure(error: Error) {
        print(error)
    }
}


