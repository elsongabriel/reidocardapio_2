//
//  ViewController.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 27/09/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class Main: UIViewController {
    
    @IBOutlet weak var lblSemConexao : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSemConexao.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (Utilities.isConnectedToNetwork()){
            sleep(2)
            self.performSegueWithIdentifier("principal", sender: self)
        }
        else{
            lblSemConexao.hidden = false
        }

    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

