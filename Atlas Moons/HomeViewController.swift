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
    var currentPlanet: Planet?
    let sizeCell = CGFloat(200).dp
    var previewItemScrolled: Int = 0
    @IBOutlet weak var namePlanetLabel: UILabel!
    @IBOutlet weak var moonsPlanetLabel: UILabel!
    @IBOutlet weak var startView: StartView!{didSet{
        startView.delegate = self
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.alpha = 0
        setupView()
        setupGestures()
    }
    
    private func animateView(){
        collectionView.animateShow()
        viewCircle.animateShow()
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))
                                                        as? ThumbnailPlanetCollectionViewCell else {
            return
        }
        cell.animatePlanet()
        animateInfoPlanet(Planet(type: .earth), show: true)
        currentPlanet = Planet(type: .earth)
        sceneViewController()?.planet = Planet(type: .earth)
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
        viewCircle.alpha = 0
    }
    
    @objc func swipeRightGestureRecognizer(){
        guard currentCenterIndex()?.item ?? 0 > 1 else {return}
        previewItemScrolled = 0
        scroll(velocity: -20, offset: -CGFloat(100).dp)
        generateFeedback()
    }
    
    @objc func swipeLeftGestureRecognizer(){
        guard let currentCenterItem = currentCenterIndex()?.item,
            currentCenterItem <= planets.count - 1,
            previewItemScrolled != currentCenterItem else {
            return
        }
        previewItemScrolled = currentCenterItem
        scroll(velocity: 20, offset: CGFloat(100).dp)
        generateFeedback()
    }
    
    var collectionViewContentSize: CGSize{
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * CGFloat(200).dp,
                      height: collectionView!.bounds.height)
    }
    
    var anglePerItem: CGFloat {
        return atan(CGFloat(200).dp / 250)
    }
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0)-1) * anglePerItem : 0
    }
    
    private func scroll(velocity: CGFloat, offset: CGFloat){
        let contentOffset: CGFloat = collectionView.contentOffset.x + offset
        var finalContentOffset = contentOffset
        let factor = -angleAtExtreme/(collectionViewContentSize.width -
            collectionView!.bounds.width)
        let proposedAngle = contentOffset * factor
        let ratio = proposedAngle/anglePerItem
        var multiplier: CGFloat
        if (velocity > 0) {
            multiplier = ceil(ratio)
        } else if (velocity < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        finalContentOffset = multiplier * anglePerItem / factor
        collectionView.setContentOffset(CGPoint(x: finalContentOffset, y: 0), animated: true)
    }
    
    private func currentCenterIndex() -> IndexPath?{
        let center = self.view.convert(self.collectionView.center, to: self.collectionView)
        return collectionView.indexPathForItem(at: center)
    }
    
    private func setPlanet(cell: ThumbnailPlanetCollectionViewCell){
        cell.animatePlanet()
        guard let planet = cell.planet else {return}
        animateInfoPlanet(planet, show: true)
        sceneViewController()?.planet = planet
        currentPlanet = planet
    }
    
    @IBAction func showInfoPlanet() {
        guard let planet = currentPlanet else {return}
        sceneViewController()?.presentInfoPlanet(planet)
    }
    
    
    private func animateInfoPlanet(_ planet: Planet?, show: Bool){
        if let planet = planet {
            namePlanetLabel.setAttributes(text: planet.name.uppercased(),
                                          font: Okomito.medium(size: CGFloat(22).dp),
                                          textSpacing: CGFloat(7).dp,
                                          color: .white)
            moonsPlanetLabel.setAttributes(text: planet.moonsDescription.uppercased(),
                                           font: Okomito.light(size: CGFloat(12).dp),
                                           textSpacing: 0.0,
                                           color: UIColor.white.withAlphaComponent(0.5))
        }
        
        namePlanetLabel.animate(show: show,
                                withDimissTransform: CGAffineTransform(scaleBy: 0.7))
        moonsPlanetLabel.animate(show: show,
                                 withDimissTransform: CGAffineTransform(scaleBy: 0.7))
        
    }
    
    private func sceneViewController() -> ScenePlanetsViewController?{
        return children.first {
            ($0 as? ScenePlanetsViewController) != nil
        } as? ScenePlanetsViewController
    }
    
    private func generateFeedback(){
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    func showCollectionPlanets(_ show: Bool){
        collectionView.animate(show: show)
        namePlanetLabel.animate(show: show,
                                withDimissTransform: CGAffineTransform(scaleBy: 0.7))
        moonsPlanetLabel.animate(show: show,
                                 withDimissTransform: CGAffineTransform(scaleBy: 0.7))
        viewCircle.animate(show: show)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? ThumbnailPlanetCollectionViewCell else {return}
            cell.hideMoons()
        }
        animateInfoPlanet(nil, show: false)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let centerIndexPath = currentCenterIndex() else {return}
        switch centerIndexPath {
        case let center where center.item <= planets.count:
            guard let cell = collectionView.cellForItem(at: IndexPath(item: previewItemScrolled == centerIndexPath.item ? centerIndexPath.item : centerIndexPath.item - 1,
                                                                      section: centerIndexPath.section)) as? ThumbnailPlanetCollectionViewCell else { return }
            setPlanet(cell: cell)
        default:
            guard let cell = collectionView.cellForItem(at: IndexPath(item: centerIndexPath.item - 1,
                                                                      section: centerIndexPath.section)) as? ThumbnailPlanetCollectionViewCell else { return }
            setPlanet(cell: cell)
        }
    }
}

extension HomeViewController: StartViewDelegate{
    func completion() {
        animateView()
    }
}
