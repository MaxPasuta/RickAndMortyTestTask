//
//  TableViewController.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var itemArray = [Result]()
    
    var nextPage:String? = NetworkDataFetch.shared.firstPage
    
    var isPagination = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createSpinerFooret() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.style = .medium
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    
    // infinite scroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        if position > (scrollView.contentSize.height - scrollView.frame.height){
            
            if !isPagination {
                self.tableView.tableFooterView = createSpinerFooret()
                isPagination = true
                
                // last page loaded
                if nextPage == nil{
                    tableView.tableFooterView = nil
                    isPagination = true
                    return
                }
                
                guard let nextPage = nextPage else { return }
                
                NetworkDataFetch.shared.fetch20Persons(urlString: nextPage, responce: {[weak self] persons, error in
                    // data available
                    if error == nil{
                        guard let persons = persons else {return}
                        self?.itemArray.append(contentsOf: persons.results)
                        self?.nextPage = persons.info.next
                        self?.tableView.reloadData()
                    }
                    else {
                        print(error!.localizedDescription)
                    }
                    self?.tableView.tableFooterView = nil
                    self?.isPagination = false
                })
            }
            else { return }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell{
            
            let item = itemArray[indexPath.row]
            cell.refresh(person: item)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailController = storyboard.instantiateViewController(identifier: "Detail") as? DetailPersonController else{return}
        
        let item = itemArray[indexPath.row]
        
        detailController.id = item.id
        show(detailController, sender: nil)
    }
}
