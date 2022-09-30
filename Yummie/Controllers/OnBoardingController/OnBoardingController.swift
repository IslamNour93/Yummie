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
    
    private var currentPage = 0{
        didSet{
            slideControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextButton.setTitle("Get started", for: .normal)
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
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
    
    //MARK: - Actions
    
    @IBAction func nextButton(_ sender: Any) {
        
        if currentPage == slides.count-1{
            let navigationVc = storyboard?.instantiateViewController(withIdentifier: "navigationVc") as! UINavigationController
            navigationVc.modalPresentationStyle = .fullScreen
            navigationVc.modalTransitionStyle = .flipHorizontal
            present(navigationVc, animated: true, completion: nil)
        }else{
        onboardingCollectionView.isPagingEnabled = false
            currentPage+=1
        let indexPath = IndexPath(item: currentPage, section: 0)
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        onboardingCollectionView.isPagingEnabled = true
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
    }
}
