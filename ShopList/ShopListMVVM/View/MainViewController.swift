//
//  ViewController.swift
//  ShopList
//
//  Created by RK Adithya on 29/05/25.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var tableView : UITableView!
    private let viewModel = ArticlesViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        viewModel.fetchArticles()
    }

    private func setupTableView() {

        tableView.register(UINib(nibName: ArticleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }

        viewModel.onError = { error in
            print("Error: \(error)")
            self.showToast(message: "Loading Cached data")
        }
    }

    @objc private func refreshData() {
        viewModel.fetchArticles(isRefreshing: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        if let article = viewModel.article(at: indexPath.row) {
            cell.configure(with: article)
        }

        if indexPath.row == viewModel.totalCount - 1 {
            viewModel.loadNextPage()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let article = viewModel.article(at: indexPath.row) {
            let vc = DetailWebViewController()
            vc.shopTitle = article.title
            vc.htmlContent = article.bodyHTML
            navigationController?.pushViewController(vc, animated: true)        }
       
    }
}
