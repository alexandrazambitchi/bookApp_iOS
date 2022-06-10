//
//  ViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 01.06.2022.
//

import UIKit
import RealmSwift

class BookItem: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var no_pages: Int = 0
    @objc dynamic var date_finished: Date = Date()
    @objc dynamic var genre: String = ""
    
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    private let realm = try! Realm()
    private var data : Results<BookItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(BookItem.self).sorted(byKeyPath: "no_pages", ascending: true)
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
        print(book)
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? DetailsViewController else {
            return
        }
        vc.book = book
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        print(book)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = book.title
        navigationController?.pushViewController(vc, animated: true)
        self.refresh()
        
    }
    
    @IBAction func didTapAddButton() {
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
        }
        vc.completionHandler = {
            [weak self] in
            self?.refresh()
            
        }
        
        vc.title = "New Book"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh() {
        data = realm.objects(BookItem.self).sorted(byKeyPath: "no_pages", ascending: true)
        table.reloadData()
    }
}


