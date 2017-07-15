//
//  ListaBairros.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 06/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class ListaBairros: UITableViewController, UINavigationControllerDelegate {
    
    var bairros = ["Mostrar Todos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bairros.appendContentsOf(listaBairrosWeb)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bairros.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        
        cell.textLabel?.text = bairros[indexPath.row]
        
        if bairroSelecionado != -1 && bairroSelecionado == indexPath.row  {
            tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = .Checkmark
        bairroSelecionado = indexPath.row
        enderecoBusca.setBairro(bairros[bairroSelecionado])
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = .None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
