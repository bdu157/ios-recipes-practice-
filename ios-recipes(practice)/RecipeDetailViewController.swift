//
//  RecipeDetailViewController.swift
//  ios-recipes(practice)
//
//  Created by Dongwoo Pae on 6/6/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    
    var recipe: Recipe? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
      
    }
    
    
    func updateViews() {
        guard let recipe = recipe , isViewLoaded else {return}
            self.recipeName.text = recipe.name
            self.recipeDetailTextView.text = recipe.instructions
    }

}
