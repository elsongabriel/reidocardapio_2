//
//  ListaRestaurantes.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 13/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

class ListaRestaurantes: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myTableView: UITableView!
    
    var listaRestaurantes : [Restaurante]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaRestaurantes = [Restaurante]()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        carregarRestaurantes()
    }
    
    func carregarRestaurantes(){
        let urlWBS = NSURL(string:"http://egcservices.com.br/webservices/ios/cardapio/listar_rests.php")!
        let request = NSMutableURLRequest(URL:urlWBS)
        request.HTTPMethod = "POST"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            
            if(error != nil){
                print("error = \(error!)")
                
                let alert = UIAlertController(title: "Aconteceu um Erro!", message: "Por favor, tente novamente!", preferredStyle:UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            
            do{
                let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if let parseJSON = myJSON {
                        self.listaRestaurantes = [Restaurante]()
                        let results = parseJSON["restaurantes"] as! NSArray
                        
                        if (results.count > 0){
                            for result in results {
                                let rest = Restaurante()
                                
                                let i = Int(result["id"] as! String)!
                                let n = result["nome"] as! String
                                let e = result["endereco"] as! String
                                let lt = result["latitude"] as! String
                                let ln = result["longitude"] as! String
                                let k = result["km_permitidos"] as! String
                                
                                rest.setId(i)
                                rest.setNome(n)
                                rest.setEndereco(e)
                                
                                rest.setLatitude(lt)
                                rest.setLongitude(ln)
                                rest.setKms(k)
                                
                                //rest.setRestaurante(i, nome: n, endereco: e, lat: lt, long: ln, kms: k)
                                
                                self.listaRestaurantes.append(rest)
                                
//                                alert.addAction(UIAlertAction(title: "\(rest.getNome()) - \(rest.getEndereco())", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
//                                    
//                                    self.tracarRota(rest)
//                                    
//                                }))
                                
                            }
                            
                            self.myTableView.reloadData()
                            //alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
                            
                            //self.presentViewController(alert, animated: true, completion: nil)
                            
                        }else{
                            print("não trouxe rests")
                        }
                        
                    }
                })
                
            }catch{ }
        }
        task.resume()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaRestaurantes.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        
        cell.textLabel?.text = listaRestaurantes[indexPath.row].getNome()
        
        return cell
    }
    
    let categorias = ["açaí", "carnes", "comida Caseira"]
    
    @IBAction func btnComida(sender: AnyObject) {
        
        let alert = UIAlertController(title: title, message: "", preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Mostrar Todos", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            print("mostrar tods categorias")
            
        }))
        
        
        for cat in categorias{
           
            alert.addAction(UIAlertAction(title: cat, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                
                print("\(cat)")
                
            }))
        }
        
        
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    @IBAction func btnOrdenar(sender: AnyObject) {
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//        let cell = tableView.cellForRowAtIndexPath(indexPath)!
//        cell.accessoryType = .Checkmark
//        bairroSelecionado = indexPath.row
//        enderecoBusca.setBairro(bairros[bairroSelecionado])
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
