//
//  TableViewCell.swift
//  Bookmark
//
//  Created by Alikhan Tangirbergen on 15.08.2023.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    static let identifier = "BookmarkTableViewCell"
    var urlLink = URL(string: "")
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, url : URL) {
        titleLabel.text = title
        urlLink = url
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let urlButton = UIButton()
        urlButton.translatesAutoresizingMaskIntoConstraints = false
        urlButton.setImage(UIImage(named: "urlButton"), for: .normal)
        urlButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        contentView.addSubview(urlButton)
        contentView.addSubview(titleLabel)
        
        urlButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func openLink() {
        if let url = URL(string: urlLink!.absoluteString) {
            print("Opening URL: \(url)")
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL: \(urlLink!.absoluteString)")
        }
    }
}
