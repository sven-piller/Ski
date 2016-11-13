//
//  RootViewController.swift
//  Ski
//
//  Created by LEOS Develop on 13.11.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    enum RootViewType: Int {
        case Now = 0
        case Day
        case week

        static var count: Int {
            return RootViewType.week.rawValue + 1
        }
    }

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }


    // Notwendig zu implementierende Methoden aus UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RootViewType.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Dequeue Reusable Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "someCell", for: indexPath)

        // Configure Cell
        cell.contentView.backgroundColor = .green

        return cell

    }

    // Funktionen für die Views

    func setupView() {
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "someCell")
    }






    
}
