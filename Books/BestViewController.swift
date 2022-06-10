//
//  BestViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 02.06.2022.
//

import UIKit

class BestViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var bestBooks: BooksJson = BooksJson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://jsonkeeper.com/b/2PQJ"
        let url = URL(string: urlString)
        
        guard url != nil else{
            return
        }
        let session = URLSession.shared
    
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in let decoder = JSONDecoder()
            self.bestBooks = try! decoder.decode(BooksJson.self, from: data!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        dataTask.resume()
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestBooks.books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBest", for: indexPath)
        cell.textLabel!.text = bestBooks.books![indexPath.row].title
        
        let titleBook = bestBooks.books![indexPath.row].title
        print(titleBook)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = bestBooks.books![indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "moreview") as? MoreViewController else {
            return
        }
        vc.book = book
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = book.title
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
