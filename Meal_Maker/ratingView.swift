//
//  ratingView.swift
//  Meal_Maker
//
//  Created by 김호중 on 2019/07/24.
//  Copyright © 2019 hojung. All rights reserved.
//

import UIKit

protocol RatingViewDelegate {
    func ratingStatusChanged()
}

class ratingView: UIStackView {
    
    var delegate: RatingViewDelegate?
    
    private var ratingButtons: [UIButton] = []
    
    public var rating: Int = 0 {
        didSet {
            delegate?.ratingStatusChanged()
            updateButtonSelectingStates()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
    }
    
    private func setUpButton() {
        
        self.spacing = 4
        
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        let highlightedStar = UIImage(named: "highlightedStar")
        
        for index in 0..<5 {
            
            let button = UIButton()
            
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            button.tag = index + 1
            
            button.addTarget(self, action: #selector(selectedStar(sender:)), for: .touchUpInside)
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            
            self.addArrangedSubview(button)
            ratingButtons.append(button)
            
        }
        
    }
    
    @objc func selectedStar(sender: UIButton) {
        print("selected star \(sender.tag)")
        rating = sender.tag
    }
    
    func updateButtonSelectingStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            
            button.isSelected = index < self.rating
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
