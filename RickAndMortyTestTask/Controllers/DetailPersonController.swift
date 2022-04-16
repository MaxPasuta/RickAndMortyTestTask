//
//  DetailPersonController.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import UIKit

class DetailPersonController: UIViewController {
    
    var id = 0
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    @IBOutlet weak var numberEpisodesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPerson()
    }
    
    private func getPerson(){
        NetworkDataFetch.shared.fetchDetailPerson(id: id, responce: {[weak self] person, error in
            if error == nil {
                guard let person = person else {return}
                self?.refresh(person: person)
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
    func refresh(person: PersonDetailModel){
        personImage.sd_setImage(with: URL(string: person.image), completed: nil)
        title = person.name
        speciesLabel.text = "Species: \(person.species)"
        genderLabel.text = "Gender: \(person.gender)"
        statusLabel.text = "Status: \(person.status)"
        lastLocationLabel.text = "Last location: \(person.location.name)"
        numberEpisodesLabel.text = "Episode count: \(person.episode.count)"
    }

}

