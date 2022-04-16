//
//  TableViewCell.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    

    func refresh(person: Result){
        nameLabel.text = person.name
        speciesLabel.text = "species: \(person.species)"
        genderLabel.text = "gender: \(person.gender)"
        personImage.sd_setImage(with: URL(string: person.image), completed: nil)
    }
}
