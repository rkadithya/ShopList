//
//  DetailWebViewController.swift
//  ShopList
//
//  Created by RK Adithya on 29/05/25.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController {
    var htmlContent: String?
    var shopTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if let title = shopTitle {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.numberOfLines = 2
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.lineBreakMode = .byTruncatingTail
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.minimumScaleFactor = 0.7
            navigationItem.titleView = titleLabel
        }

        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        if let html = htmlContent {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}
