//
//  SmallestBooksViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 03.06.2022.
//

import UIKit
import RealmSwift

class SmallestBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    private let realm = try! Realm()
    private var data : Results<BookItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(BookItem.self).sorted(byKeyPath: "no_pages", ascending: true).filter("no_pages <= 101")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = data[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? DetailsViewController else {
            return
        }
        vc.book = book
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = book.title
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func refresh() {
        data = realm.objects(BookItem.self).sorted(byKeyPath: "no_pages", ascending: true)
        table.reloadData()
    }

}
