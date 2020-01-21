//
//  MealModel.swift
//  Meal_Maker
//
//  Created by 김호중 on 2019/07/24.
//  Copyright © 2019 hojung. All rights reserved.
//

import UIKit

class MealModel:NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(photo, forKey: "photo")
        aCoder.encode(rating, forKey: "rating")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let photo = aDecoder.decodeObject(forKey: "photo") as? UIImage
        let rating = aDecoder.decodeInteger(forKey: "rating")
        
        // A convenience initializer must call another initializer from the same class.
        self.init(name: name, photo: photo, rating: rating)
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    override init() {
        self.name = ""
        self.rating = 0
    }
    
    init(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
}
