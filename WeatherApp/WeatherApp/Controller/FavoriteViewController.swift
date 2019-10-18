//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by EricM on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    var fave = [Favorite](){
        didSet{
            collectionView.reloadData()
        }
    }

    let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0 , y: 88 , width: 414, height: 818), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        layout.scrollDirection = .vertical
        let nib = UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "faveCell")
        //collection.backgroundColor = .white
        return collection
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        do {
            fave = try SavePersistenceHelper.manager.getFavorite()
        } catch {
            print(error)
        }
    }

}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fave.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 414, height: 250)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "faveCell", for: indexPath) as? FavoriteCollectionViewCell else{ return UICollectionViewCell() }
        cell.pixaImage.image = UIImage(data: fave[indexPath.row].image)
        
        
        return cell
    }
    
    
}
