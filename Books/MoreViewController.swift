//
//  MoreViewController.swift
//  Books
//
//  Created by Alexandra Zambitchi on 02.06.2022.
//

import UIKit

class MoreViewController: UIViewController {

    public var book : Books?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var pagesLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book?.title
        authorLabel.text = book?.author
        pagesLabel.text = String(book?.no_pages ?? 0)
        genreLabel.text = book?.genre
        yearLabel.text = String(book?.year ?? 0)
        
        shareButton.addTarget(self, action: #selector(sharePage), for: .touchUpInside)
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
