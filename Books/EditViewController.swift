//
//  EditViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 02.06.2022.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController, UITextFieldDelegate {

    public var book: BookItem?
    @IBOutlet var titleField: UITextField!
    @IBOutlet var authorField: UITextField!
    @IBOutlet var noPagesField: UITextField!
    @IBOutlet var genreField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    public var deletionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = book?.title
        authorField.text = book?.author
        noPagesField.text = String(book?.no_pages ?? 0)
        genreField.text = book?.genre
        datePicker.date = book?.date_finished ?? Date()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        return true
    }
    
    
    @objc func didTapSaveButton(){
        if let title = titleField.text, !title.isEmpty {
            if let author = authorField.text, !author.isEmpty {
//                if let genre = genreField.text!, !genre.isEmpty{
                    if let pages = noPagesField.text, !pages.isEmpty {
                        let date = datePicker.date
                        let genre = genreField.text
                        guard let selectedBook = self.book else {
                            return
                        }
                        realm.beginWrite()
                        realm.delete(selectedBook)
                        try! realm.commitWrite()
                        
                        deletionHandler?()
                        
                        let newBook = BookItem()
                        newBook.title = title
                        newBook.author = author
                        newBook.no_pages = Int(pages) ?? 0
                        newBook.date_finished = date
                        newBook.genre = genre!
                        try! realm.write{realm.add(newBook)}
                        completionHandler?()
                        navigationController?.popToRootViewController(animated: true)
                    }
//                }
            }
        }
        else{
            print("empty")
        }
    }

}
