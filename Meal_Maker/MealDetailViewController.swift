//
//  MealDetailViewController.swift
//  Meal_Maker
//
//  Created by 김호중 on 2019/07/24.
//  Copyright © 2019 hojung. All rights reserved.
//

import UIKit

extension MealDetailViewController: RatingViewDelegate {
    func ratingStatusChanged() {
        saveButtonStatus()
    }
}

class MealDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ratingView: ratingView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var mealModel = MealModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingView.delegate = self

        titleField.text = mealModel.name
        ratingView.rating = mealModel.rating
        mealImageView.image = mealModel.photo ?? UIImage(named: "defaultPhoto")
        
        saveButton.isEnabled = false
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(imageTap))
        mealImageView.addGestureRecognizer(tapGesture)
        mealImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTap() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self

        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        mealImageView.image = selectedImage
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func popCloseView(_ sender: Any) {
        
        // self.navigationController.push
        // pop
        
        // self.present
        // dismiss
        
        let presenting = presentingViewController is UINavigationController
        
        if presenting {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    @IBAction func didChanged(_ sender: UITextField) {
        
        saveButtonStatus()
        
    }
    
    func saveButtonStatus() {
        
        if titleField.text?.isEmpty ?? true {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func saveMeal(_ sender: Any) {
        print("save Meal")
        
        mealModel.name = titleField.text ?? ""
        mealModel.rating = ratingView.rating
        mealModel.photo = mealImageView.image
        // model save
        self.performSegue(withIdentifier: "toMealList", sender: self)
        
    }
    
    
}

