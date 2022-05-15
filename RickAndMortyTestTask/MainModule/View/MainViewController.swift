//
//  MainViewController.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 13.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: MainViewPresenterProtocol!
    var isPagination = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rick and Morty characters"
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
    }
}

extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.persons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell{
            let item = presenter.persons?[indexPath.row]
            guard let item = item else {return UITableViewCell()}
            cell.refresh(person: item)
            return cell
        }
        return UITableViewCell()
    }
}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = presenter.persons?[indexPath.row]
        presenter.tapOnThePerson(person: person)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension MainViewController: MainViewProtocol {
    func succes() {
        tableView.tableFooterView = nil
        isPagination = false
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension MainViewController: UIScrollViewDelegate{
    
    private func createSpinerFooret() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.style = .medium
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        if position > (scrollView.contentSize.height - scrollView.frame.height){
            
            if !isPagination {
                tableView.tableFooterView = createSpinerFooret()
                isPagination = true
                
                // last page loaded
                if presenter.nextPage == nil{
                    tableView.tableFooterView = nil
                    isPagination = true
                    return
                }
                presenter.infiniteScroll()
            }
        }
    }
}
