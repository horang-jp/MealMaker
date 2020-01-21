//
//  mealCell.swift
//  Meal_Maker
//
//  Created by 김호중 on 2019/07/24.
//  Copyright © 2019 hojung. All rights reserved.
//

import UIKit

class MealCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ratingView: ratingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
