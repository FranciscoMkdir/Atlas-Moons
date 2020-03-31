//
//  ViewController.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 10/1/19.
//  Copyright © 2019 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewCircle: UIView!
    let planets = [Planet(type: .earth), Planet(type: .mars), Planet(type: .jupiter),
                   Planet(type: .saturn), Planet(type: .uranus), Planet(type: .neptune),
                   Planet(type: .pluto)]
    let sizeCell = CGFloat(400).dp
    let paddingCell = CGFloat(12).dp
    var currentScrollAnimation = false
    var previewItemScrolled: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        setupView()
        setupGestures()
    }
    
    private func setupGestures(){
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightGestureRecognizer))
        swipeRightGesture.direction = .right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftGestureRecognizer))
        swipeLeftGesture.direction = .left
        collectionView.addGestureRecognizer(swipeRightGesture)
        collectionView.addGestureRecognizer(swipeLeftGesture)
    }
    
    private func setupView(){
        viewCircle.layer.masksToBounds = true
        viewCircle.layer.cornerRadius = 250
        viewCircle.layer.borderColor = UIColor.white.cgColor
        viewCircle.layer.borderWidth = 2
        viewCircle.clipsToBounds = true
    }
    
    @objc func swipeRightGestureRecognizer(){
        guard currentCenterIndex()?.item ?? 0 > 1,
              !currentScrollAnimation else {return}
        previewItemScrolled = 0
        collectionView.scrollToPreviousItem(sizeCell: sizeCell + CGFloat(13).dp)
        currentScrollAnimation = true
    }
    
    @objc func swipeLeftGestureRecognizer(){
        guard let currentCenterItem = currentCenterIndex()?.item,
            currentCenterItem <= planets.count - 1,
            !currentScrollAnimation,
            previewItemScrolled != currentCenterItem else {
            return
        }
        previewItemScrolled = currentCenterItem
        collectionView.scrollToNextItem(sizeCell: sizeCell + CGFloat(13).dp)
        currentScrollAnimation = true
    }
    
    private func currentCenterIndex() -> IndexPath?{
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        return collectionView.indexPathForItem(at: center)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ThumbnailPlanetCollectionViewCell else {
            fatalError("Error: not found cell ThumbnailPlanetCollectionViewCell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let customCell = cell as? ThumbnailPlanetCollectionViewCell else {
            return
        }
        customCell.planet = planets[safe: indexPath.item]
        customCell.animatePlanet()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        currentScrollAnimation = false
    }
}

