//
//  ViewController.swift
//  Meal_Maker
//
//  Created by 김호중 on 2019/07/24.
//  Copyright © 2019 hojung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mealList: [MealModel] = []
    var isEditMode: Bool = false
    @IBOutlet weak var mealTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let loadMealModels = loadMeals() {
            self.mealList = loadMealModels
        }
        
        if mealList.count == 0 {
            let dummy1 = MealModel.init(name: "Spaghetti", photo: UIImage(named: "meal3"), rating: 3)
            let dummy2 = MealModel.init(name: "Kebob", photo: UIImage(named: "meal2"), rating: 5)
            let dummy3 = MealModel.init(name: "Pasta", photo: UIImage(named: "meal1"), rating: 2)
            mealList.append(dummy1)
            mealList.append(dummy2)
            mealList.append(dummy3)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentDetail" {
            
        } else if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MealDetailViewController
            
            let selectedCell = sender as! MealCell
            if let selectedIndexPath = mealTableView.indexPath(for: selectedCell) {
                detailVC.mealModel = mealList[selectedIndexPath.row]
            }
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        // .source = The source view controller for the segue.
        guard let detailVC = sender.source as? MealDetailViewController else {
            return
        }
        
        if let selectedIndexPath = self.mealTableView.indexPathForSelectedRow {
            
            mealList[selectedIndexPath.row] = detailVC.mealModel
            
            self.mealTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            
            // when it is occured to reload, cell is cleared by selected option
//            self.mealTableView.deselectRow(at: selectedIndexPath, animated: true)
        } else {
            
            let insertIndexPath = IndexPath(row: mealList.count, section: 0)
            
            mealList.append(detailVC.mealModel)
            
            self.mealTableView.insertRows(at: [insertIndexPath], with: .none)
            
        }
    
        saveMeals()
    }
    
    func saveMeals() {
        // archive
        // path
        // DispatchQueue = DispatchQueue manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system.
        DispatchQueue.global().async {
            let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
            
            guard let archiveUrl = documentDirectory?.appendingPathComponent("meals") else {
                return
            }
        
//        let isSuccessSave = NSKeyedArchiver.archiveRootObject(mealList, toFile: archiveUrl.path)
        
            do{
                let archiveData =  try NSKeyedArchiver.archivedData(withRootObject: self.mealList, requiringSecureCoding: true)
                try archiveData.write(to: archiveUrl)
            } catch {
                print(error)
            }
        }
//        if isSuccessSave {
//            print("success saved")
//        } else {
//            print("failed saved")
//        }
    }
    
    func loadMeals() -> [MealModel]? {
        
        let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let archiveUrl = documentDirectory?.appendingPathComponent("meals") else {
            return nil
        }
        
        guard let codedData = try? Data(contentsOf: archiveUrl) else {
            return nil
        }
        
        guard let unarchivedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) else {
            return nil
        }
        
        return unarchivedData as? [MealModel]
//        return NSKeyedUnarchiver.unarchiveObject(withFile: archiveUrl.path) as? [MealModel]
    }
 
    @IBAction func doEdit(_ sender: Any) {
        isEditMode.toggle()
        mealTableView.setEditing(isEditMode, animated: true)
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mealList.remove(at: indexPath.row)
            mealTableView.deleteRows(at: [indexPath], with: .automatic)
            saveMeals()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mealCell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealCell
        mealCell.nameLabel.text = mealList[indexPath.row].name
        mealCell.ratingView.rating = mealList[indexPath.row].rating
        mealCell.mealImageView.image = mealList[indexPath.row].photo ?? UIImage(named: "defaultPhoto")
        
        
        
        return mealCell
    }
    

    
}
