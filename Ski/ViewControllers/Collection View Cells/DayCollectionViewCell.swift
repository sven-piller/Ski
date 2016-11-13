//
//  DayCollectionViewCell.swift
//  Ski
//
//  Created by LEOS Develop on 13.11.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    static let ReuseIdentifier = "DayCollectionViewCell"
    let viewController: DayViewController

    // Init
    override init(frame: CGRect){
        // Init view controller
        viewController = DayViewController()

        super.init(frame: frame)
        setupViewController()
    }

    required init?(coder aDecoder: NSCoder){
        // Init view controller
        viewController = DayViewController()

        super.init(coder: aDecoder)
        setupViewController()
    }

    private func setupViewController() {
        // Config view Controller
        viewController.view.backgroundColor = .blue

        // Add view controller to content view
        contentView.addSubview(viewController.view)

        if let view = viewController.view {
            view.translatesAutoresizingMaskIntoConstraints = false

            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0).isActive = true
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0).isActive = true

        }
    }
}
