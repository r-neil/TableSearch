//
//  MainViewController.swift
//  TableSearch
//
//  Created by neil-r on 9/22/15.
//  Copyright © 2015 neil-r. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var destinationLabel: UILabel!
    
    //storing Segue name in a struct
    private struct Storyboard{
        static let segueToTableVC = "toTableView"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationLabel.text = ""
    }

    //Segue to SearchTableView called here.  No need to "prepareForSegue" since no values are being passed in this example
    @IBAction func showTableViewButton() {
        performSegueWithIdentifier(Storyboard.segueToTableVC, sender: nil)
    }
    
    //used to unwind from SearchTableView.
    @IBAction func returnToMainVC(segue: UIStoryboardSegue){}
}
