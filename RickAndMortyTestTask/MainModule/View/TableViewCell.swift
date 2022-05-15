//
//  TableViewCell.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 13.05.2022.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
      
    func refresh(person: Result){
        
        loadingSpinner.startAnimating()
        loadingSpinner.isHidden = false
        nameLabel.text = person.name
        speciesLabel.text = "species: \(person.species)"
        genderLabel.text = "gender: \(person.gender)"
        
        personImage.sd_setImage(with: URL(string: person.image)) {[weak self] _, error, _, _ in
            if error == nil {
                self?.loadingSpinner.isHidden = true
                self?.loadingSpinner.stopAnimating()
            }
        }
    }
}
