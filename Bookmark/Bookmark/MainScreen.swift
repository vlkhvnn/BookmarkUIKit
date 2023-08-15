//
//  ViewController.swift
//  Bookmark
//
//  Created by Alikhan Tangirbergen on 14.08.2023.
//

import UIKit
import SnapKit

struct Bookmark : Codable {
    var title : String
    var url : URL
}

var userBookmarks : [Bookmark] = []

class MainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let bookmarks = BookmarksAPI.getBookmarks()
    
    let bookmarksTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(#function)
        
        
        
        if let bookmarkData = UserDefaults.standard.data(forKey: "bookmarks"),
           let savedBookmarks = try? JSONDecoder().decode([Bookmark].self, from: bookmarkData) {
            userBookmarks = savedBookmarks
        }
        
        let topText = UILabel()
        topText.textColor = .black
        topText.text = userBookmarks.isEmpty ? "Bookmark App" : "List"
        topText.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        let centerText = UILabel()
        centerText.textColor = .black
        centerText.text = "Save your first bookmark"
        centerText.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        centerText.numberOfLines = 0
        centerText.textAlignment = .center
        
        let buttonText = UILabel()
        buttonText.text = "Add Bookmark"
        buttonText.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        buttonText.textColor = .white
        
        let bottomButton = UIButton()
        bottomButton.setTitle("", for: .normal)
        bottomButton.backgroundColor = .black
        bottomButton.layer.cornerRadius = 16
        bottomButton.addSubview(buttonText)
        bottomButton.addTarget(self, action: #selector(addBookmark), for: .touchUpInside)
        
        bookmarksTableView.translatesAutoresizingMaskIntoConstraints = false
        
        [topText, bottomButton, bookmarksTableView].forEach {
            view.addSubview($0)
        }
        
        bookmarksTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        
        if BookmarksAPI.getBookmarks().isEmpty {
            view.addSubview(centerText)
            centerText.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
            }
        }
        
        bookmarksTableView.snp.makeConstraints { make in
            make.top.equalTo(topText.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(bottomButton.snp.top).offset(-16)
        }
        
        topText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(56)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        
        buttonText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func addBookmark() {
        print("Button is tapped")
        showAddBookmarkAlert()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(userBookmarks[indexPath.row].title)"
        return cell
    }
    
    func showAddBookmarkAlert() {
        let alertController = UIAlertController(title: "Add Bookmark", message: "", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Bookmark title"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Bookmark link"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            if let titleTextField = alertController.textFields?[0], let urlTextField = alertController.textFields?[1] {
                if let title = titleTextField.text, let urlString = urlTextField.text, let url = URL(string: urlString) {
                    // Here, you can use the 'title' and 'url' to create and save the bookmark
                    userBookmarks.append(Bookmark(title: title, url: url))
                    if let encodedData = try? JSONEncoder().encode(userBookmarks) {
                        UserDefaults.standard.set(encodedData, forKey: "bookmarks")
                    }
                    print(userBookmarks)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}


