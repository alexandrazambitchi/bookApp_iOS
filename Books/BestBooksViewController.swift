//
//  BestBooksViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 03.06.2022.
//

import UIKit
import RealmSwift

class BestBooksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    private let realm = try! Realm()
    private var data : Results<BookItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(BookItem.self)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }


}
