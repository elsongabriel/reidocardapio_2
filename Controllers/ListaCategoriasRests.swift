//
//  ListaCategoriasRests.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 14/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit

class ListaCategoriasRests: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCategoriasWeb.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        
        cell.textLabel?.text = listaCategoriasWeb[indexPath.row].getDescricao()
        
        let myCat = categoriaSelecionada.getId()
        if myCat != -1 && listaCategoriasWeb[indexPath.row].getId() == myCat {
            tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        if cell.accessoryType == .Checkmark {
            cell.accessoryType = .None
            categoriaSelecionada = Categoria()
            categoriaSelecionada.setId(-1)
        }else{
            cell.accessoryType = .Checkmark
            categoriaSelecionada = listaCategoriasWeb[indexPath.row]
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = .None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
}
