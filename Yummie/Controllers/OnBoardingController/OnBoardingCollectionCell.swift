//
//  OnBoardingCollectionCell.swift
//  Yummie
//
//  Created by Islam NourEldin on 12/09/2022.
//

import UIKit

class OnBoardingCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    static let identifier = String(describing: OnBoardingCollectionCell.self)
    
    func setupCell(_ onboardingSlide:OnBoardingSlide){
        slideImageView.image = onboardingSlide.image
        slideTitle.text = onboardingSlide.title
        slideDescription.text = onboardingSlide.description
    }
}
