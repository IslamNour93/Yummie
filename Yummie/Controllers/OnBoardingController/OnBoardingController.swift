//
//  OnBoardingController.swift
//  Yummie
//
//  Created by Islam NourEldin on 12/09/2022.
//

import UIKit

class OnBoardingController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    
    @IBOutlet weak var slideControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var slides = [OnBoardingSlide]()
    
    private var currentPage = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        slideControl.currentPage = currentPage
        
    }
    
    //MARK: - Helpers
    
    private func setupDelegates(){
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.delegate = self
        slides = [OnBoardingSlide(image: #imageLiteral(resourceName: "slide2"), title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world."),
                  OnBoardingSlide(image: #imageLiteral(resourceName: "slide1"), title: "World-Class Chefs", description: "Our dishes are prepared by only the best."),
                  OnBoardingSlide(image: #imageLiteral(resourceName: "slide3"), title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.")]
    }
    
    @IBAction func nextButton(_ sender: Any) {
    }
    
}

extension OnBoardingController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionCell.identifier, for: indexPath) as! OnBoardingCollectionCell
        let slide = slides[indexPath.row]
        cell.setupCell(slide)
        return cell
    }
    
    
}
extension OnBoardingController:UICollectionViewDelegate{
    
}
extension OnBoardingController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        
        currentPage = Int(scrollView.contentOffset.x/width)
        
        slideControl.currentPage = currentPage
    }
}
