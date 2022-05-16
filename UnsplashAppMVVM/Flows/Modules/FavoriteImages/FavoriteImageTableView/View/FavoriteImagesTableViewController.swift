//
//  FavoriteImagesTableViewController.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 14.05.2022.
//

import UIKit

class FavoriteImagesTableViewController: UITableViewController {

    private var viewModel: FavoriteImagesViewModelProtocol! {
        didSet {
            viewModel.fetchFavoriteImages {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = FavoriteImagesViewModel()
        tableView.register(FavoriteImageTableViewCell.self, forCellReuseIdentifier: FavoriteImageTableViewCell.identifier)
        tableView.rowHeight = 100
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteImageTableViewCell.identifier, for: indexPath) as? FavoriteImageTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCellViewModel(for: indexPath)
        return cell
    }
}
