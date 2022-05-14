//
//  ViewController.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 13.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        let photosVC = UINavigationController(rootViewController: ImageCollectionViewController())
        self.setViewControllers([photosVC], animated: true)

        let images = ["house.fill", "heart.fill"]
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        guard let items = self.tabBar.items else { return }
        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index], withConfiguration: configuration)
        }
        tabBar.tintColor = .black
    }
}

