//
//  InfoRestaurante.swift
//  reidocardapio
//
//  Created by Elson Costa on 19/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class InfoRestaurante: UIViewController {

    @IBOutlet var mySegment: UISegmentedControl!
    
    @IBOutlet var cardapioContainer: UIView!
    @IBOutlet var informacaoContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        switch mySegment.selectedSegmentIndex
        {
        case 0:
//            NSLog("cardapio selected")
            self.cardapioContainer.hidden = false
            self.informacaoContainer.hidden = true
        case 1:
//            NSLog("info selected")
            self.cardapioContainer.hidden = true
            self.informacaoContainer.hidden = false
        default:
            break;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}