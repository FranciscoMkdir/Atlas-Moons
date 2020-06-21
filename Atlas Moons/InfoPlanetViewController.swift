//
//  InfoPlanetViewController.swift
//  Atlas Moons
//
//  Created by Francisco Javier Delgado García on 25/04/20.
//  Copyright © 2020 Francisco Javier Delgado García. All rights reserved.
//

import UIKit

protocol InfoPlanetDelegate: class {
    func infoDismiss()
    func highlightMoon(item: Int)
}

class InfoPlanetViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonBack: UIButton!{didSet{
        buttonBack.prepareForAnimation(position: .right)
        }}
    @IBOutlet weak var backgroundEffectView: UIVisualEffectView!{didSet{
        backgroundEffectView.alpha = 0
        }}
    @IBOutlet weak var topButtonBackConstraint: NSLayoutConstraint!{didSet{
        topButtonBackConstraint.constant = CGFloat(20).dp
        }}
    var isAnimationCompleted = false
    weak var delegate: InfoPlanetDelegate?
    var planet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        collectionView.register(InfoPlanetViewCell.self, forCellWithReuseIdentifier: "InfoPlanet")
        collectionView.register(InfoMoonViewCell.self, forCellWithReuseIdentifier: "InfoMoon")
        collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateView()
    }
    
    private func animateView(){
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundEffectView.alpha = 0.55
        }) { _ in
            self.isAnimationCompleted = true
            self.animateCollectionView()
            self.buttonBack.animateShow(delay: 0.5)
        }
    }
    
    private func animateCollectionView(){
        collectionView.visibleCells.forEach {
            ($0 as? AnimateCollectionViewCell)?.startAnimation()
        }
    }
    
    @IBAction func tapBack() {
        UIView.animate(withDuration: 0.45, animations: {
            self.view.alpha = 0
        }) { _ in
            self.delegate?.infoDismiss()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func generateFeedback(){
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

extension InfoPlanetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (planet?.moons ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoPlanet", for: indexPath) as? InfoPlanetViewCell else {
                fatalError("InfoPlanetViewCell not found")
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoMoon", for: indexPath) as? InfoMoonViewCell else {
                fatalError("InfoMoonViewCell not found")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard var customCell = cell as? AnimateCollectionViewCell else {
            return
        }
        customCell.indexItem = indexPath.item
        customCell.planet = planet
        if isAnimationCompleted{
            (cell as? AnimateCollectionViewCell)?.startAnimation()
        }
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let centerIndex = currentCenterIndex() else {return}
        generateFeedback()
        delegate?.highlightMoon(item: centerIndex.item)
    }
    
    private func currentCenterIndex() -> IndexPath?{
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        return collectionView.indexPathForItem(at: center)
    }
}

