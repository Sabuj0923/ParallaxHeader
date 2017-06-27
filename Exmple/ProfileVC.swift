//
//  ViewController.swift
//  Exmple
//
//  Created by Roman Sorochak on 6/23/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import ParallaxHeader
import SnapKit


class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    weak var headerImageView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupParallaxHeader()
        setupImageView()
    }
    
    
    //MARK: private
    
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        
        imageView.blurView.setup(style: UIBlurEffectStyle.dark, alpha: 1).enable()
        
        headerImageView = imageView
        
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 400
        tableView.parallaxHeader.minimumHeight = 40
        tableView.parallaxHeader.mode = .centerFill
        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            print(parallaxHeader.progress)
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
        
        // Label for vibrant text
        let vibrantLabel = UILabel()
        vibrantLabel.text = "Vibrant"
        vibrantLabel.font = UIFont.systemFont(ofSize: 40.0)
        vibrantLabel.sizeToFit()
        vibrantLabel.textAlignment = .center
        imageView.blurView.vibrancyContentView?.addSubview(vibrantLabel)
        vibrantLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupImageView() {
        guard let imageView = headerImageView else {
            return
        }
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imageDidTap(gesture:))
        )
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: actions
    
    @objc private func imageDidTap(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            if self.tableView.parallaxHeader.height == 400 {
                self.tableView.parallaxHeader.height = 200
            } else {
                self.tableView.parallaxHeader.height = 400
            }
        }
    }
    
    
    //MARK: table view data source/delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "some row text"
        
        return cell
    }
}

