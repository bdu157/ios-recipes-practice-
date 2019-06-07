//
//  ViewController.swift
//  ios-recipes(practice)
//
//  Created by Dongwoo Pae on 6/5/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipeTableViewController : RecipesTableViewController?
    {
        didSet {
            self.recipeTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipeTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkClient.fetchRecipes { (data, error) in
            if let error = error {
                NSLog("there is an error: \(error)")
                return
            }
            
//            guard let data = data else {
//                print(NSError())
//                return
//            }
            //you can also unwrap data -> [Recipe]? as well
            
            DispatchQueue.main.async {
                self.allRecipes = data ?? []
            }
            
        }
    }

 
    @IBAction func searchTextField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededSegue" {
            self.recipeTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    func filterRecipes() {

        if let searchTerm = textField.text {
            self.filteredRecipes = self.allRecipes.filter {$0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)}
        } else {
            self.filteredRecipes = self.allRecipes
        }
        
        if textField.text == "" {
            self.filteredRecipes = allRecipes
        }
        
        self.recipeTableViewController?.recipes = self.filteredRecipes
    }
    
}

