//
//  ImagesCollectionViewController.swift
//  UnsplashAppMVVM
//
//  Created by Dinmukhammed Sagyntkan on 13.05.2022.
//

import UIKit

class ImageCollectionViewController: UICollectionViewController {

    private var viewModel: ImageCollectionViewModelProtocol! {
        didSet {
            viewModel.fetchImages {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        viewModel = ImageCollectionViewModel()
        view.backgroundColor = .white
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let frame = view.safeAreaLayoutGuide.layoutFrame
        return CGSize(
            width: (view.frame.size.width / 3) - 1,
            height: (frame.height / 4) - 1
        )
    }
}
