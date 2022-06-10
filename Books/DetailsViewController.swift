//
//  DetailsViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 01.06.2022.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {

    public var book: BookItem?
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var pagesLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    
    private let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book?.title
        authorLabel.text = book?.author
        pagesLabel.text = String(book?.no_pages ?? 0)
        genreLabel.text = book?.genre
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        dateLabel.text = formatter.string(from: book!.date_finished)
        
        shareButton.addTarget(self, action: #selector(sharePage), for: .touchUpInside)
        
        
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        navigationItem.rightBarButtonItems = [editButton, deleteButton]
    }
    
    @objc private func didTapDelete() {
        guard let selectedBook = self.book else {
            return
        }
        realm.beginWrite()
        realm.delete(selectedBook)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapEdit() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "edit") as? EditViewController else {
            return
        }
        vc.book = book
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Edit book"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func sharePage() {
        guard let image = UIImage(named: "books"), let url = URL(string: "https://www.amazon.com/books-used-books-textbooks/b?ie=UTF8&node=283155")
        else {
            return
        }
        let shareVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareVC, animated: true)
    }
    

}
