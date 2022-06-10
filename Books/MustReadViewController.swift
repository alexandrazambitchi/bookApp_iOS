//
//  MustReadViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 03.06.2022.
//

import UIKit

class MustReadViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var mustBooks: BooksJson = BooksJson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://jsonkeeper.com/b/C8E8"
        let url = URL(string: urlString)
        
        guard url != nil else{
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
//                print("decoding")
                do {
                    let booksFromJson = try decoder.decode(BooksJson.self, from: data!)
                    print(booksFromJson)
                    self.mustBooks = booksFromJson
                }
                catch{
                    print("Error in JSON parsing")
                }
            }
        }
        dataTask.resume()
        tableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mustBooks.books?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mostCell", for: indexPath)
        cell.textLabel?.text = mustBooks.books![indexPath.row].title
        cell.detailTextLabel?.text = mustBooks.books![indexPath.row].author
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let books = mustBooks.books![indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "moreview") as? MoreViewController else {
            return
        }
        vc.book = books
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = books.title
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
